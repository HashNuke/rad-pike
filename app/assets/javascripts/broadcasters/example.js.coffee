# Example broadcaster
# All broadcasters should implement their own subscribe() and unsubscribe() methods
# Broadcasters are initiated like
#
#     new App.broadcasters.Example(userId, token)
#

class App.broadcasters.Example

  @subscriptions: {}

  constructor: (@userId, @token)->

  subscribe: ->

  unsubscribe: ->
