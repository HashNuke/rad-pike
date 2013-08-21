App.controller "ConversationsCtrl", ($scope, $timeout, $location, Auth, Conversation)->
  $scope.conversations = []
  $scope.filterOption = "all"

  successCallback = (conversations)->
    $scope.conversations = conversations

  errorCallback = (errorData)->
    console.log "error"


  $scope.openChat = (conversationId) ->
    $location.path("/conversations/#{conversationId}")

  $scope.applyFilter = ->
    console.log "filter", $scope.filterOption
    Conversation.query({filter: $scope.filterOption}, successCallback, errorCallback)

  @updateTimes = =>
    for conversation, i in $scope.conversations
      #NOTE take a conversation's time and assign it back again to force a change
      $scope.conversations[i].created_at = $scope.conversations[i].created_at
    $timeout @updateTimes, 60000

  Conversation.query({filter: $scope.filterOption}, successCallback, errorCallback)
  $timeout @updateTimes, 60000
