App.resolvers.UserWithMessages = (User, $q, $route)->

  deferred = $q.defer()
  successCallback = (user)->
    deferred.resolve user
  errorCallback = (errorData)-> deferred.reject()

  requestParams =
    id: $route.current.params.id

  User.withMessages(requestParams, successCallback, errorCallback)
  deferred.promise
