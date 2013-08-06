App.factory 'Message', ($resource)->

  #TODO
  #collection routes: conversations with pagination. Use default GET index action.
  customActions =
    update:  {method: "PUT"}

  $resource("/api/messages/:collectionRoute:id/:memberRoute",
    { id: "@id", collectionRoute: '@collectionRoute', memberRoute: '@memberRoute'}, customActions)
