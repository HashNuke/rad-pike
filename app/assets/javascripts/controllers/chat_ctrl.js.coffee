App.controller "ChatCtrl", ($scope, conversation, Auth, Conversation, Activity, $timeout)->
  $scope.isInfobarVisible = true
  $scope.page = 1
  $scope.conversation = conversation
  $scope.triggerWidgetEvents = false
  historyActivity = {activity_type: "load"}

  scrollToRecentActivity = ->
    angular.element('.activities').scrollTop(
      angular.element('.activities-inner-wrapper').prop('scrollHeight') + 100)


  scrollToRecentActivityIfNecessary = ->
    scrollToRecentActivity()


  $scope.changeState = (stateType)->
    successCallback = (conversation)->
      $scope.conversation.attrs.current_issue_state_type = conversation.attrs.current_issue_state_type

    errorCallback = (errorData)->
      console.log "error"

    Conversation.update(
      {id: $scope.conversation.id, conversation: {state_type: stateType}},
      successCallback,
      errorCallback
    )


  $scope.postMsg = ()->
    if $scope.chatInput.trim() == ""
      $scope.chatInput = ""
      #NOTE force set because angular is checking against trimmer value
      angular.element(".chat-input").val('')
      return

    successCallback = (activity)->
      $scope.lastActivityParams = activity.created_at
      $scope.conversation.activities.push activity
      if $scope.triggerWidgetEvents && window.parent.RadPikeWidget && typeof(window.parent.RadPikeWidget.events.onNewChatMessage) == "function"
        window.parent.RadPikeWidget.events.onNewChatMessage()
      $scope.chatInput = ""
      scrollToRecentActivity()

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


  updateConversation = (conversation, prepend = true)->
    $scope.conversation.attrs = conversation.attrs
    return if conversation.activities.length == 0

    # remove the temporary "loading" msg before adding activities
    $scope.conversation.activities.shift()

    if prepend == true
      $scope.conversation.activities = conversation.
        activities.concat($scope.conversation.activities)
      $scope.oldestActivityParams =
        before: conversation.activities[0].created_at
        activityId: conversation.activities[0].id

    else
      for activity in conversation.activities
        $scope.conversation.activities.push(activity)
        $scope.conversation.activities.shift()

      lastActivity = conversation.activities[conversation.activities.length - 1]
      $scope.lastActivityParams =
        after: lastActivity.created_at
        activityId: lastActivity.id

    $scope.conversation.activities.unshift(historyActivity)
    scrollToRecentActivityIfNecessary()


  $scope.loadHistory = ->
    params =
      id: $scope.conversation.id
      before: $scope.oldestActivityParams.before
      activityId: $scope.oldestActivityParams.activityId

    successCallback = (conversation)->
     updateConversation(conversation)

    errorCallback = (errorData)->
      console.log "error"

    Conversation.get(params, successCallback, errorCallback)


  setUserIfRequired = ->
    return if Auth.isAuthenticated()
    Auth.setUser(conversation.user)
    $scope.triggerWidgetEvents = true if !conversation.user.is_support_user


  hideInfobarIfWidget = ->
    $scope.isInfobarVisible = false if $scope.conversation.user.id == Auth.user()["id"]


  setActivityStamps = ->
    lastActivity = $scope.conversation.activities[$scope.conversation.activities.length - 1]
    if lastActivity?
      $scope.lastActivityParams =
        after: lastActivity.created_at
        activityId: lastActivity.id
    else
      $scope.lastActivityParams =
        after: $scope.conversation.attrs.created_at
        activityId: 0

    if $scope.conversation.activities.length > 0
      $scope.oldestActivityParams =
        before: $scope.conversation.activities[0].created_at
        activityId: $scope.conversation.activities[0].id
      $scope.conversation.activities.unshift(historyActivity)
    else
      $scope.oldestActivityParams =
        before: $scope.conversation.attrs.created_at


  setUserIfRequired()
  hideInfobarIfWidget()
  setActivityStamps()


  poller = (->
    params = {id: $scope.conversation.id}
    params['after'] = $scope.lastActivityParams['after']
    params['activityId'] = $scope.lastActivityParams['activityId']

    scrollToRecentActivity() #NOTE just making sure to scroll
    Conversation.get params, (conversation)=> updateConversation(conversation, false)
    poller = $timeout arguments.callee, 3000
  )()


  #NOTE give it 50ms of time to load the activities into the view
  $scope.$on '$viewContentLoaded', -> $timeout(scrollToRecentActivity, 50)
  $scope.$on '$destroy', -> $timeout.cancel(poller)
