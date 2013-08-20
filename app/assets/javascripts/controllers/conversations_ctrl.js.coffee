App.controller "ConversationsCtrl", ($scope, $timeout, $location, Auth, Conversation)->
  $scope.conversations = []

  successCallback = (conversations)->
    $scope.conversations = $scope.conversations.concat(conversations)

  errorCallback = (errorData)->
    console.log "error"


  $scope.openChat = (conversationId) ->
    $location.path("/conversations/#{conversationId}")


  @updateTimes = =>
    for conversation, i in $scope.conversations
      #NOTE take a conversation's time and assign it back again to force a change
      $scope.conversations[i].created_at = $scope.conversations[i].created_at
    $timeout @updateTimes, 60000

  Conversation.query(successCallback, errorCallback)
  $timeout @updateTimes, 60000
