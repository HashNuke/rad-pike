App.directive 'ngPostMessage', ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    element.bind 'keyup', (event) ->
      keycode = if event.keyCode then event.keyCode else event.which
      scope.postMsg() if(keycode == 13)
