App.resolvers.UserWithMessages = (Message, $q, $route)->

  deferred = $q.defer()
  successCallback = (user)->
    deferred.resolve user
  errorCallback = (errorData)-> deferred.reject()

  requestParams =
    id: $route.current.params.user_id

  Message.get(requestParams, successCallback, errorCallback)
  deferred.promise
