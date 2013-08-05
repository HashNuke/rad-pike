App.factory 'Message', ($resource)->

  #TODO
  #collection routes: conversations with pagination
  customActions = {}

  $resource("/api/messages/:collectionRoute:id/:memberRoute",
    { id: "@id", collectionRoute: '@collectionRoute', memberRoute: '@memberRoute'}, customActions)
