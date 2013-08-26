#= require easyxdm

#NOTE because this file is also used seperately
window.App ||= {}

class App.XdmProtocol
  listeners: {}
  iframeProps:
    style:
      width: "100%"
      height: "100%"


  constructor: (@options={})->
    xdmOptions =
      onMessage: (message, origin)=>
        message = JSON.parse(message)
        return false if !message['action']? || !@listeners[message['action']]?
        listener(message['data']) for listener in @listeners[message['action']]


    if @options.consumer
      xdmOptions['remote']    = @options.remote
      xdmOptions['container'] = @options.container
      xdmOptions['onReady']   = ()=>
        #NOTE This is for the consumer to send and the provider to receive
        @sendMsg('start') if @options.start == true
      xdmOptions['props']     = @iframeProps

    @protocol = new easyXDM.Socket xdmOptions


  sendMsg: (action, data) ->
    msg = {action}
    msg['data'] = data if data?
    @protocol.postMessage(JSON.stringify(msg))


  on: (action, callback) ->
    @listeners[action] = [] if !@listeners[action]?
    @listeners[action].push callback

  registerEventListeners: (events) ->
    for event, callback of events
      @on event, callback
