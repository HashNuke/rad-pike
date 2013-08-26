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
  iframeProps:
    style:
      position: "absolute"
      bottom: 0
      right:  0
      width:  "20em"
      height: "2em"
      right:  "0em"
      bottom: "0em"
      border: "1px solid #CCC"
      "box-shadow": "0px 0px 3px 1px #CCC"


  constructor: (@options={})->
    xdmOptions =
      onMessage: (message, origin)=>
        return false if !message['action']? || !@listeners[message['action']]?
        @listeners[message['action']](message['data'])

    if @options.consumer == true
      xdmOptions["remote"]    = "<%= @base_url %>/widgets/support"
      xdmOptions["container"] = @options.containerId
      xdmOptions["onReady"] = ()=>
        @protocol.sendMsg({action: "start"}) if @options.start == true
      xdmOptions['props'] = @iframeProps

    console.log xdmOptions
    @protocol = new easyXDM.Socket xdmOptions


  sendMsg: (action, data="") ->
    msg = {action}
    msg['data'] = data if !data.trim() == ""
    @protocol.postMessage(JSON.stringify(msg))


  on: (action, callback) ->
    @listeners[action] = [] if !@listeners[action]?
    @listeners[action].push callback

  registerEventListeners: (events) ->
    (@listeners[event] = callback) for event, callback of events


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
  App.xdm = new XdmProtocol(consumer: false)
  startWidget = ->
    angular.bootstrap(document.body, ['RadPike'])
    $("#support-intro").hide()

  $("#support-intro").on("click", startWidget);
  App.xdm.on "start", startWidget
