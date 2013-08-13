class Broadcaster
  def self.broadcast(activity)
    #TODO detect what kind of broadcasting is being used
    if defined?(FAYE_CLIENT)
      FAYE_CLIENT.publish "/conversations/#{activity.conversation_id}", MessageSerializer.new(activity)
    end
  end
end