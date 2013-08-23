App.controller "ChatCtrl", ($scope, conversation, Auth, Conversation, Activity, $timeout)->
  $scope.isInfobarVisible = true
  $scope.page = 1
  $scope.conversation = conversation
  $scope.triggerWidgetEvents = false


  scrollToRecentActivity = ->
    $('.activities').scrollTop($('.activities-inner-wrapper').prop('scrollHeight') + 50)


  #NOTE If user isn't set on window object, then he isn't staff
  if !Auth.isAuthenticated()
    Auth.setUser(conversation.user)
    if !conversation.user.is_support_user
      $scope.triggerWidgetEvents = true


  lastActivity = $scope.conversation.activities[$scope.conversation.activities.length - 1]
  if lastActivity?
    $scope.lastActivityStamp = lastActivity.created_at
  else
    $scope.lastActivityStamp = $scope.conversation.created_at

  #NOTE infobar not required if it's the widget
  if $scope.conversation.user.id == Auth.user()["id"]
    $scope.isInfobarVisible = false


  $scope.changeState = (stateType)->
    successCallback = (conversation)->
      $scope.conversation.current_issue_state_type = conversation.current_issue_state_type

    errorCallback = (errorData)->
      console.log "error"

    Conversation.update(
      {id: $scope.conversation.id, conversation: {state_type: stateType}},
      successCallback,
      errorCallback
    )


  $scope.postMsg = ()->
    successCallback = (data)->
      $scope.conversation.activities.push data
      if $scope.triggerWidgetEvents && window.parent.RadPikeWidget && typeof(window.parent.RadPikeWidget.events.onNewChatMessage) == "function"
        window.parent.RadPikeWidget.events.onNewChatMessage()
      $scope.chatInput = ""

    errorCallback = ()->
      console.log "error"

    Activity.save({
        conversation_id: $scope.conversation.id
        activity: {
          conversation_id: $scope.conversation.id,
          receiver_id:     $scope.conversation.user.id,
          content:         $scope.chatInput
        }
      }, successCallback, errorCallback)


  # poller = (->
  #   params = {conversation_id: $scope.conversation.id}
  #   params['previous_stamp'] = $scope.lastActivityStamp

  #   Activity.query params, (msgs)=>
  #     for msg in msgs
  #       $scope.conversation.activities.push(msg) if msg.sender.id != Auth.user()["id"]
  #       $scope.lastActivityStamp = params['previous_stamp'] = msg.created_at
  #       scrollToRecentActivity()
  #   poller = $timeout arguments.callee, 3000
  # )()


  $scope.$on '$destroy', -> $timeout.cancel(poller)
  $scope.$on '$viewContentLoaded', scrollToRecentActivity


  #TODO required only for loading history
  # successCallback = (conversation)->
  #  prepend result with current list

  # errorCallback = (errorData)->
  #   console.log "error"

  # Conversation.query(successCallback, errorCallback)
