#NOTE borrowed and modified ServerAuth class from Ryan Bates

class FayeAuth

  attr_accessor :redis

  def initialize(options={})
    @redis = options[:redis]
  end

  def incoming(message, callback)
    if message['channel'] == "/meta/subscribe"
      if message['ext'].respond_to?(:[])
        user_token = @redis.get "user:#{message['ext']['user_id']}:token"
        if message['ext'] && message['ext']['auth_token'] != user_token
          message['error'] = 'Invalid authentication token'
        end
      end
    end
    callback.call(message)
  end


  # IMPORTANT: clear out the auth token so it is not leaked to the client
  def outgoing(message, callback)
    if message['ext'] && message['ext']['auth_token']
      message['ext'] = {} 
    end
    callback.call(message)
  end
end
