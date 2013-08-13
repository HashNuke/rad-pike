class Broadcaster
  def self.broadcast(activity)
    if defined?(FAYE_CLIENT)
      FAYE_CLIENT.publish "/conversations/#{activity.conversation_id}", MessageSerializer.new(activity)
    end
  end
end