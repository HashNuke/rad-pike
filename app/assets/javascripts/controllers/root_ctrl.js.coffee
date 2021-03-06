App.controller 'RootCtrl', ($scope, $location)->
  $scope.navigateToConversationList = ->
    $location.path("/")

  $scope.$on '$routeChangeSuccess', (event, current, prev)->
    if current.controller == "MainCtrl"
      $scope.chatView = false
      $scope.conversationsView = true
    else
      $scope.chatView = true
      $scope.conversationsView = false
