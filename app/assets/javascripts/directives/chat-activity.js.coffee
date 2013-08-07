App.directive 'chatActivity', ->
  {
    restrict: "E"
    scope:
      activityId:      "@"
      activityType:    "@"
      content:         "@"
      senderName:      "@"
      senderId:        "@"
      receiverId:      "@"
      receiverName:    "@"


    transclude: true
    template: """
      <div class='activity'>{{activityId}}</div>
    """

    compile: (tElement, tAttrs, transclude) ->
      tElement.append("This was included in processing.")
  }