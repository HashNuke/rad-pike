App.controller "ConversationsCtrl", ($scope, Auth, Conversation)->
  $scope.conversations = []

  successCallback = (conversations)->
    console.log "conversations", conversations
    $scope.conversations = $scope.conversations.concat(conversations)

  errorCallback = (errorData)->
    console.log "error"

  Conversation.query(successCallback, errorCallback)
