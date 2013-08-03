App.factory 'User', ($resource)->
  customActions =
    update:  {method: "PUT"}
    withMessages: {method: "GET", params: {memberRoute: 'with_messages'}}


  $resource("/api/users/:collectionRoute:id/:memberRoute",
    { id: "@id", collectionRoute: '@collectionRoute', memberRoute: '@memberRoute'}, customActions)
