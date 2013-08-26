#= require jquery
#= require easyxdm
#= require angular
#= require angular-resource
#= require moment
#= require init
#= require_tree ../resolvers
#= require_self
#= require_tree ../../templates
#= require_tree ../controllers
#= require_tree ../services
#= require_tree ../filters
#= require_tree ../directives

class XdmProtocol
  listeners: {}

  constructor: (@container)->
    @protocol = new easyXDM.Socket
      onMessage: (message, origin)=>
        return false if !message['action']? || !@listeners[message['action']]?
        @listeners[message['action']](message['data'])


  sendMsg: (action, data) ->
    @protocol.postMessage(JSON.stringify({action, data}))


  on: (action, callback) ->
    @listeners[action] = callback

  registerEvents: (events) ->
    (@listeners[event] = callback) for event, callback of events


  removeEvent: (action) ->
    delete(@listener[action])


App.xdm = new XdmProtocol()

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
