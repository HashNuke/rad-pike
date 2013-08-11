App.controller "ConversationsCtrl", ($scope, $timeout, $location, Auth, Message)->
  $scope.conversations = []
  console.log $scope.broadcaster

  successCallback = (conversations)->
    console.log "conversations", conversations
    $scope.conversations = $scope.conversations.concat(conversations)

  errorCallback = (errorData)->
    console.log "error"


  $scope.openChat = (userId) ->
    $location.path("/chats/#{userId}")


  @updateTimes = =>
    for conversation, i in $scope.conversations
      #NOTE take a conversation's time and assign it back again to force a change
      $scope.conversations[i].created_at = $scope.conversations[i].created_at
    $timeout @updateTimes, 60000

  Message.query(successCallback, errorCallback)
  $timeout @updateTimes, 60000
