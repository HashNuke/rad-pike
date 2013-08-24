App.directive 'activity', ()->
  restrict: "E"
  scope:
    activityId:   "@"
    type:         "@"
    content:      "@"
    senderName:   "@"
    senderId:     "@"
    receiverId:   "@"
    receiverName: "@"
    loadHistory:  "&"


  link: (scope, element, attrs, transclude)->
    attrs.$observe('activityId senderName content', (val)->
      element.html JST["activities/#{attrs.type}"]({activity: attrs})
    )
