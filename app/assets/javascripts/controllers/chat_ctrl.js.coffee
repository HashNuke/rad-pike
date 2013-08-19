App.controller "ChatCtrl", ($scope, conversation, Auth, Conversation, Message, Faye)->
  $scope.isInfobarVisible = true
  $scope.conversation = conversation

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


  Faye.subscribe "/conversations/#{$scope.conversation.id}", (msg)->
    $scope.conversation.messages.push(msg) if msg.sender.id != Auth.user()["id"]


  #TODO required only for loading history
  # successCallback = (conversation)->
  #  prepend result with current list

  # errorCallback = (errorData)->
  #   console.log "error"

  # Conversation.query(successCallback, errorCallback)
