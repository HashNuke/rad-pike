App.factory 'User', ($resource)->
  customActions =
    update:  {method: "PUT"}

  $resource("/api/users/:collectionRoute:id/:memberRoute",
    { id: "@id", collectionRoute: '@collectionRoute', memberRoute: '@memberRoute'}, customActions)
