App.controller "ChatCtrl", ($scope, Auth, Message)->
  $scope.userWithMessages = {}

  successCallback = (userWithMessages)->
    console.log "messages", userWithMessages
    #TODO instead prepend the messages with the current list
    $scope.userWithMessages = userWithMessages

  errorCallback = (errorData)->
    console.log "error"

  # Message.query(successCallback, errorCallback)
