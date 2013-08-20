App.factory 'Faye', ($window, Auth) ->

  client = new Faye.Client("#{$window.broadcasterHost}/faye")

  authExtension =
    outgoing: (message, callback)->
      if message.channel == "/meta/subscribe"
        message['ext'] = {
          user_id:    Auth.user()["id"]
          auth_token: Auth.user()["authentication_token"]
        }
      callback(message)

  client.addExtension(authExtension)
  client
