App.controller "ChatCtrl", ($scope, userWithMessages, Auth, Message)->
  $scope.userWithMessages = userWithMessages

  #TODO required only for loading history
  # successCallback = (userWithMessages)->
  #   console.log "messages", userWithMessages
  #   #TODO instead prepend the messages with the current list
  #   $scope.userWithMessages = userWithMessages

  # errorCallback = (errorData)->
  #   console.log "error"

  # Message.query(successCallback, errorCallback)
