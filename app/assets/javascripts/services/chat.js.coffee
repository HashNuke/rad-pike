App.factory 'Chat', ($resource)->

  $resource("/api/chats/:collectionRoute:id/:memberRoute",
    { id: "@id", collectionRoute: '@collectionRoute', memberRoute: '@memberRoute'})
