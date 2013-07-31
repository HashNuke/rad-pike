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
      "/login"
      template:   JST["users/auth"]()
      controller: "AuthCtrl"
    )
    .when(
      "/account"
      template:   JST["users/account"]()
      controller: "AccountCtrl"
      resolve:
        account: (Account)-> Account.get()
    )
    .when(
      "/"
      template:   JST["main"]()
      controller: "MainCtrl"
    )
    .when(
      "/"
      template:   JST["conversations"]()
      controller: "ConversationsCtrl"
      resolve:
        userWithConversation: App.resolvers.UserWithConversation
    )
    .otherwise(template: "This doesn't exist")
