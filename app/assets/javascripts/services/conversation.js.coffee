App.factory 'Conversation', ($resource)->

  #TODO
  #collection routes: conversations with pagination. Use default GET index action.
  customActions =
    update:  {method: "PUT"}
    user_conversation:
      method: "GET"
      action: "user_conversation"
      params: {collectionRoute: "user_conversation"}

  $resource("/api/conversations/:collectionRoute:id/:memberRoute",
    { id: "@id", collectionRoute: '@collectionRoute', memberRoute: '@memberRoute'}, customActions)
