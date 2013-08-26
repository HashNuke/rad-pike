class XdmProtocol
  listeners: {}

  iframeProps:
    style:
      position: "absolute"
      bottom: 0
      right:  0
      width:  "20em"
      height: "20em"
      right:  "0em"
      bottom: "0em"
      border: "1px solid #CCC"
      "box-shadow": "0px 0px 3px 1px #CCC"

  constructor: (@container)->
    @protocol = new easyXDM.Socket
      remote: "<%= @base_url %>/widgets/support"
      container: @container
      props: @iframeProps
      onMessage: (message, origin)=>
        message = JSON.parse(message)
        return false if !message['action']? || !@listeners[message['action']]?
        return false if !@listeners[message['action']]?
        @listeners[message['action']](message['data'])


  sendMsg: (action, data) ->
    @protocol.postMessage(JSON.stringify({action, data}))


  on: (action, callback) ->
    @listeners[action] = callback

  registerEvents: (events) ->
    (@listeners[event] = callback) for event, callback of events


  removeEvent: (action) ->
    delete(@listener[action])


class window.RadPikeWidget
  @startWidget: false
  @events:  {}
  templateCache: {}
 
  constructor: (options={})->
    # Options:
    #   * containerId: inside which the element should be contained
    #   * startWidget: true/false
    #   * unique_user_id
    #   * user_name
    #   * user_data
    #   * events: {onNewMessage, onChatStart, onChatClose}

    @constructor.events = options.events if options.events?
    @constructor.startWidget = true if options.startWidget == true

    @xdm = new XdmProtocol(options.containerId)
    @xdm.registerEvents(@constructor.events)

    iframeStyle = """
      position: absolute;
      bottom: 0; right: 0;
      width: 20em;
      height: 1em;
      right: 0em;
      bottom: 0em;
      border: 1px solid #CCC;
      box-shadow: 0px 0px 3px 1px #CCC;
    """

    # template = """<iframe id="radpike-support-widget" src='http://localhost:3000/widgets/support'
    #   style='#{iframeStyle}'></iframe>
    # """

    # document.write(template)
