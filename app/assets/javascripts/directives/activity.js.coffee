App.directive 'activity', ()->
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

  link: (scope, element, attrs)->
    attrs.$observe('activityId senderName content', (val)->
      element.html """
        <div class="activity">
          <div class="sender">#{attrs.senderName}:</div>
          <div class="content">#{attrs.content}</div>
        </div>
      """
    )
