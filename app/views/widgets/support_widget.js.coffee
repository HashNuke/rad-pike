class window.RadPikeWidget
  @startWidget: false
  @events:  {}
 

  # Options:
  #   * containerId: inside which the element should be contained
  #   * start: true
  #   * data
  #     * unique_user_id
  #     * user_name
  #     * extras
  #   * events: {newMessage, chatStart, chatClose}
  constructor: (@options={})->
    @xdm = new App.XdmProtocol(
      remote:    "<%= @base_url %>/widgets/support"
      start:     @options.start
      consumer:  true
      container: @options.containerId
    )

    @xdm.on "chatStart", ->
      console.log "inbuilt stuff"

    @xdm.registerEventListeners(@options.events)
