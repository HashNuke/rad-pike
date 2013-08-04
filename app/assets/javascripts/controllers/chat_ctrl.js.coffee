App.controller "ChatCtrl", ($scope, Auth, Message)->
  $scope.messages = []

  $scope.

  successCallback = (messages)->
    console.log "messages", messages
    $scope.messages = $scope.messages.concat(messages)

  errorCallback = (errorData)->
    console.log "error"

  Chat.query(successCallback, errorCallback)
