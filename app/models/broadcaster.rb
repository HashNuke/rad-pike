class Broadcaster
  def self.broadcast(activity)
    FAYE_CLIENT.publish "/conversations/#{activity.conversation_id}", MessageSerializer.new(activity)
  end
end