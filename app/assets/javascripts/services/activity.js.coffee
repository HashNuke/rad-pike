App.factory 'Activity', ($resource)->

  customActions =
    update:  {method: "PUT"}


  $resource("/api/conversations/:conversation_id/activities/:id",
    { id: "@id", conversation_id: "@conversation_id"}, customActions)
