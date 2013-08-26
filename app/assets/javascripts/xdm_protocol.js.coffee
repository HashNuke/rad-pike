#= require easyxdm

class App.XdmProtocol
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
