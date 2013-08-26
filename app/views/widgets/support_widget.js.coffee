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



class window.RadPikeWidget
  @startWidget: false
  @events:  {}
 
  constructor: (@options={})->
    # Options:
    #   * containerId: inside which the element should be contained
    #   * start: true
    #   * data
    #     * unique_user_id
    #     * user_name
    #     * extras
    #   * events: {onNewMessage, onChatStart, onChatClose}

    @xdm = new XdmProtocol(start: @options.start, consumer: true, container: @options.containerId)
    @xdm.registerEventListeners(@options.events)
