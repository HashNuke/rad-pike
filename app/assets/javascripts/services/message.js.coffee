App.factory 'Message', ($resource)->

  customActions =
    update:  {method: "PUT"}


  $resource("/api/conversations/:conversation_id/messages/:id",
    { id: "@id", conversation_id: "@conversation_id"}, customActions)
