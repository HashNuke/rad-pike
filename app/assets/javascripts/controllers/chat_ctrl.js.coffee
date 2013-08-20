App.controller "ChatCtrl", ($scope, conversation, Auth, Conversation, Message, $timeout)->
  $scope.isInfobarVisible = true
  $scope.conversation = conversation

  lastMsg = $scope.conversation.messages[$scope.conversation.messages.length - 1]
  if lastMsg?
    $scope.lastMsgStamp = lastMsg.created_at
  else
    $scope.lastMsgStamp = $scope.conversation.created_at

  #NOTE If user isn't set on window object, then he isn't staff
  if !Auth.isAuthenticated()
    Auth.setUser(conversation.user)

  #NOTE infobar not required if it's the widget
  if $scope.conversation.user.id == Auth.user()["id"]
    $scope.isInfobarVisible = false

  $scope.postMsg = ()->
    successCallback = (data)->
      $scope.conversation.messages.push data
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

    console.log "curr", params['previous_stamp']
    Message.query params, (msgs)=>
      for msg in msgs
        $scope.conversation.messages.push(msg) if msg.sender.id != Auth.user()["id"]
        $scope.lastMsgStamp = params['previous_stamp'] = msg.created_at
      $('.messages').scrollTop($('.messages-wrapper').prop('scrollHeight') + 50)
    poller = $timeout arguments.callee, 3000
  )()


  $scope.$on "$destroy", ->
    console.log poller
    $timeout.cancel(poller)

  $('.messages').scrollTop($('.messages-wrapper').prop('scrollHeight') + 50)

  #TODO required only for loading history
  # successCallback = (conversation)->
  #  prepend result with current list

  # errorCallback = (errorData)->
  #   console.log "error"

  # Conversation.query(successCallback, errorCallback)
