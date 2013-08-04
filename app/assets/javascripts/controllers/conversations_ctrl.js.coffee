App.controller "ConversationsCtrl", ($scope, $timeout, Auth, Conversation)->
  $scope.conversations = []

  successCallback = (conversations)->
    console.log "conversations", conversations
    $scope.conversations = $scope.conversations.concat(conversations)

  errorCallback = (errorData)->
    console.log "error"

  Conversation.query(successCallback, errorCallback)


  @updateTimes = =>
    for conversation, i in $scope.conversations
      #NOTE take a conversation's time and assign it back again to force a change
      $scope.conversations[i].created_at = $scope.conversations[i].created_at
    $timeout @updateTimes, 60000

  $timeout @updateTimes, 60000
