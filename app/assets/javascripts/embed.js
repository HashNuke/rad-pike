#= require jquery
#= require angular
#= require angular-resource
#= require moment
#= require init
#= require ../xdm_protocol
#= require_tree ../resolvers
#= require_self
#= require_tree ../../templates
#= require_tree ../controllers
#= require_tree ../services
#= require_tree ../filters
#= require_tree ../directives



App.config ($routeProvider, $locationProvider, $httpProvider)->

  #NOTE Set CSRF token
  metaTags = document.getElementsByTagName('meta')
  for metaTag in metaTags
    if (metaTag.name == 'csrf-token')
      $httpProvider.defaults.headers.common['X-CSRF-Token'] = metaTag.content
      break

  App.resolvers.Conversation = (Conversation, $q, $route)->

    deferred = $q.defer()
    successCallback = (conversation)->
      deferred.resolve conversation
    errorCallback = (errorData)-> deferred.reject()

    requestParams =
      id: $route.current.params.user_id

    Conversation.user_conversation(requestParams, successCallback, errorCallback)
    deferred.promise


  $locationProvider.html5Mode(false)
  $routeProvider
    .when(
      "/"
      template:   JST["conversation"]()
      controller: "ChatCtrl"
      resolve:
        conversation: App.resolvers.Conversation
    )
    .otherwise(template: "This doesn't exist")


App.widgetInit = ->
  App.xdm = new App.XdmProtocol(consumer: false)
  startWidget = ->
    angular.bootstrap(document.body, ['RadPike'])
    $("#support-intro").hide()
    App.xdm.sendMsg "onChatStart"

  $("#support-intro").on("click", startWidget);
  App.xdm.on "start", startWidget

