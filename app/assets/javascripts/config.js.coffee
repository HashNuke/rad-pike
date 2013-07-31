App.config ($routeProvider, $locationProvider, $httpProvider)->

  #TODO Set CSRF token
  # metaTags = document.getElementsByTagName('meta')
  # for metaTag in metaTags
  #   if (metaTag.name == 'csrf-token')
  #     $httpProvider.defaults.headers.common['X-CSRF-Token'] = metaTag.content
  #     break

  $locationProvider.html5Mode(true)

  $routeProvider
    .when(
      "/"
      template:   JST["chat"]()
      controller: "ConversationsCtrl"
      resolve:
        conversation: App.resolvers.Conversations
    )
    .when(
      "/"
      template:   JST["chat"]()
      controller: "ChatCtrl"
      resolve:
        user: App.resolvers.UserWithMessages
    )
    .otherwise(template: "This doesn't exist")
