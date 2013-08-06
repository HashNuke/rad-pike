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
      template:   JST["main"]()
      controller: "MainCtrl"
    )
    .when(
      "/chats/:user_id"
      template:   JST["chat"]()
      controller: "ChatCtrl"
      resolve:
        userWithMessages: App.resolvers.UserWithMessages
    )
    .otherwise(template: "This doesn't exist")
