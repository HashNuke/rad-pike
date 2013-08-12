App.controller "ChatCtrl", ($scope, userWithMessages, Auth, Message)->
  $scope.userWithMessages = userWithMessages

  $scope.postMsg = ()->
    successCallback = (data)->
      console.log "success"

    errorCallback = ()->
      console.log "error"

    console.log "posting", $scope.chatInput
    Message.save({message: {receiver_id: $scope.userWithMessages.id, content: $scope.chatInput}}, successCallback, errorCallback)


  #TODO required only for loading history
  # successCallback = (userWithMessages)->
  #   console.log "messages", userWithMessages
  #   #TODO instead prepend the messages with the current list
  #   $scope.userWithMessages = userWithMessages

  # errorCallback = (errorData)->
  #   console.log "error"

  # Message.query(successCallback, errorCallback)
