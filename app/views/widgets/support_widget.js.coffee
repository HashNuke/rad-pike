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

    @xdm = new App.XdmProtocol(
      remote:    "<%= @base_url %>/widgets/support"
      start:     @options.start
      consumer:  true
      container: @options.containerId
    )

    @xdm.registerEventListeners(@options.events)
