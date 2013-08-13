App.resolvers.Conversation = (Message, $q, $route)->

  deferred = $q.defer()
  successCallback = (conversation)->
    deferred.resolve conversation
  errorCallback = (errorData)-> deferred.reject()

  requestParams =
    id: $route.current.params.conversation_id

  Message.get(requestParams, successCallback, errorCallback)
  deferred.promise
