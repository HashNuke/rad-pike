class Broadcaster
  def self.broadcast(message)
    #TODO detect what kind of broadcasting is being used
    if defined?(FAYE_CLIENT)
      FAYE_CLIENT.publish "/conversations/#{message.conversation_id}", MessageSerializer.new(message)
    end
  end
end
