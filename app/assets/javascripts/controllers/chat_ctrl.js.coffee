App.controller "ChatCtrl", ($scope, conversation, Auth, Conversation, Message, $timeout)->
  $scope.isInfobarVisible = true
  $scope.page = 1
  $scope.conversation = conversation
  $scope.triggerWidgetEvents = false


  scrollToRecentMsg = ->
    $('.messages').scrollTop($('.messages-wrapper').prop('scrollHeight') + 50)


  #NOTE If user isn't set on window object, then he isn't staff
  if !Auth.isAuthenticated()
    Auth.setUser(conversation.user)
    if !conversation.user.is_support_user
      $scope.triggerWidgetEvents = true


  lastMsg = $scope.conversation.messages[$scope.conversation.messages.length - 1]
  if lastMsg?
    $scope.lastMsgStamp = lastMsg.created_at
  else
    $scope.lastMsgStamp = $scope.conversation.created_at

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
      $scope.conversation.messages.push data
      if $scope.triggerWidgetEvents && window.parent.RadPikeWidget && typeof(window.parent.RadPikeWidget.events.onNewChatMessage) == "function"
        window.parent.RadPikeWidget.events.onNewChatMessage()
      $scope.chatInput = ""

    errorCallback = ()->
      console.log "error"

    Message.save({
        conversation_id: $scope.conversation.id
        message: {
          conversation_id: $scope.conversation.id,
          receiver_id:     $scope.conversation.user.id,
          content:         $scope.chatInput
        }
      }, successCallback, errorCallback)


  poller = (->
    params = {conversation_id: $scope.conversation.id}
    params['previous_stamp'] = $scope.lastMsgStamp

    Message.query params, (msgs)=>
      for msg in msgs
        $scope.conversation.messages.push(msg) if msg.sender.id != Auth.user()["id"]
        $scope.lastMsgStamp = params['previous_stamp'] = msg.created_at
        scrollToRecentMsg()
    poller = $timeout arguments.callee, 3000
  )()


  $scope.$on '$destroy', -> $timeout.cancel(poller)
  $scope.$on '$viewContentLoaded', scrollToRecentMsg


  #TODO required only for loading history
  # successCallback = (conversation)->
  #  prepend result with current list

  # errorCallback = (errorData)->
  #   console.log "error"

  # Conversation.query(successCallback, errorCallback)
