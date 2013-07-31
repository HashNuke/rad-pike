App.resolvers.UserWithMessages = (User, $q, $route)->
  if !$route.current.params.post_id
    return({post_type: "Link"});

  deferred = $q.defer()
  successCallback = (post)->
    deferred.resolve post
  errorCallback = (errorData)-> deferred.reject()

  requestParams =
    id: $route.current.params.post_id
    username: $route.current.params.username

  Post.get(requestParams, successCallback, errorCallback)
  deferred.promise
  
