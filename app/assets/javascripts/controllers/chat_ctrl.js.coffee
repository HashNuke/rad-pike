App.controller "ChatCtrl", ($scope, conversation, Auth, Message, Faye)->
  console.log conversation
  $scope.conversation = conversation

  $scope.postMsg = ()->
    successCallback = (data)->
      $scope.chatInput = ""

    errorCallback = ()->
      console.log "error"

    console.log "posting", $scope.chatInput
    Message.save({
        message: {
          conversation_id: $scope.conversation.id,
          receiver_id:     $scope.conversation.user.id,
          content:         $scope.chatInput
        }
      }, successCallback, errorCallback)


  #Faye.publish("/conversations/#{$scope.conversation.id}")

  # Subscribe
  Faye.subscribe "/conversations/#{$scope.conversation.id}", (activity)->
    $scope.conversation.messages.push activity
    $('.messages-wrapper').scrollTop($('.messages-wrapper').prop('scrollHeight'))


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
