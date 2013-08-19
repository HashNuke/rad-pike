App.controller "ChatCtrl", ($scope, conversation, Auth, Message, Faye)->
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
        message: {
          conversation_id: $scope.conversation.id,
          receiver_id:     $scope.conversation.user.id,
          content:         $scope.chatInput
        }
      }, successCallback, errorCallback)


  Faye.subscribe "/conversations/#{$scope.conversation.id}", (msg)->
    $scope.conversation.messages.push(msg) if msg.sender.id != Auth.user()["id"]

# f = new Faye.Client(); f.publish("/conversations/3", "akash")

  # Get just once (using $q - promise)
  # $scope.data = Faye.get("/channel-3")


  #TODO required only for loading history
  # successCallback = (userWithMessages)->
  #   console.log "messages", userWithMessages
  #   #TODO instead prepend the messages with the current list
  #   $scope.userWithMessages = userWithMessages

  # errorCallback = (errorData)->
  #   console.log "error"

  # Message.query(successCallback, errorCallback)
