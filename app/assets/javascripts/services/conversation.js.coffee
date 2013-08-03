App.factory 'Conversation', ($resource)->

  $resource("/api/conversations/:collectionRoute:id/:memberRoute",
    { id: "@id", collectionRoute: '@collectionRoute', memberRoute: '@memberRoute'})
