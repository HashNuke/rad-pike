App.factory "Auth", ($window, $rootScope)->

  if $window.currentUser? && !@currentUser
    @currentUser = $window.currentUser

  isAuthenticated: =>
    return true if @currentUser
    false

  setUser: (userAttributes)=>
    @currentUser = userAttributes

  user: ()=>
    @currentUser
