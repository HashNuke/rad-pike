class window.RadPikeWidget
  @startWidget: false
  @events:  {}
  templateCache: {}
 
  constructor: (options={})->
    # Options:
    #   * startWidget: true/false
    #   * user_email
    #   * user_name
    #   * events: {onNewMessage, onChatStart, onChatClose}

    @constructor.events = options.events if options.events?
    @constructor.startWidget = true if options.startWidget == true

    iframeStyle = """
      position: absolute;
      bottom: 0; right: 0;
      width: 18em;
      right: 0em;
      bottom: 0em;
      border: 1px solid #CCC;
      box-shadow: 0px 0px 3px 1px #CCC;
    """

    template = """<iframe id="radpike-support-widget" src='http://rp-demo.herokuapp.com/widgets/support'
      style='#{iframeStyle}'></iframe>
    """

    document.write(template)
    # if options.startWidget
    #   widgetIframe = document.getElementById("radpike-support-widget")
    #   document.getElementById("radpike-support-widget").contentWindow.startWidget()
