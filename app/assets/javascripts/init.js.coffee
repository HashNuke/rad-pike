window.App = angular.module('RadPike', ['ngResource', 'faye'])

class PluginManager
  widgets:    []
  formatters: []

  formatter: (name, regex, callback, options={})->
    @formatters.push({name, regex, callback, options})

  widget: (name, command, template, options={})->
    @widgets[command] = {name, command, callback, options}

  runActivityThroughWidgets: (activity, isHistory)->
    command = "//#{activity.content.trim()}"
    if @widgets[command]
      return @widgets[command].callback.apply(null, [activity, isHistory])
    false

  runActivityThroughFormatters: (activity, isHistory)->
    for formatter in @formatters when activity.content.match(formatter.regex)
      return callback.apply(null, [activity, isHistory])
    false


App.resolvers    = {}
App.plugins      = new PluginManager()
App.broadcasters = {}
