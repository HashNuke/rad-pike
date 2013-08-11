App.directive 'chatActivity', ()->
  restrict: "E"
  transclude: true
  scope:
    activityId:   "@"
    type:         "@"
    content:      "@"
    senderName:   "@"
    senderId:     "@"
    receiverId:   "@"
    receiverName: "@"

  link: (element, attrs)->
    