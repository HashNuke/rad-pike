#= require easyxdm

class XdmProtocol
  listeners: {}

  constructor: ()->
    @protocol = new easyXDM.Socket =>
      remote: "<%= @base_url %>/widgets/support"
      onMessage: (message, origin)=>
        return false if !message['action']? || !@listeners[message['action']]?
        @listeners[message['action']](message['data'])


  sendMsg: (action, data) ->
    @protocol.postMessage(JSON.stringify({action, data}))


  on: (action, callback) ->
    @listeners[action] = callback


  removeListener: (action) ->
    delete(@listener[action])



class window.RadPikeWidget
  @startWidget: false
  @events:  {}
  templateCache: {}
 
  constructor: (options={})->
    # Options:
    #   * startWidget: true/false
    #   * unique_user_id
    #   * user_name
    #   * user_data
    #   * events: {onNewMessage, onChatStart, onChatClose}

    @constructor.events = options.events if options.events?
    @constructor.startWidget = true if options.startWidget == true

    @xdm = new XdmProtocol()

    iframeStyle = """
      position: absolute;
      bottom: 0; right: 0;
      width: 20em;
      height: 20em;
      right: 0em;
      bottom: 0em;
      border: 1px solid #CCC;
      box-shadow: 0px 0px 3px 1px #CCC;
    """

    # template = """<iframe id="radpike-support-widget" src='http://localhost:3000/widgets/support'
    #   style='#{iframeStyle}'></iframe>
    # """

    # document.write(template)
