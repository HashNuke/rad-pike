class Message < ActiveRecord::Base

  belongs_to :conversation

  belongs_to :receiver, counter_cache: :received_message_count,
    class_name: "User", inverse_of: :received_messages

  belongs_to :sender,   counter_cache: :sent_message_count,
    class_name: "User", inverse_of: :sent_messages

  after_create :broadcast
  after_create :update_conversation!

  def broadcast
    Broadcaster.broadcast(self)
  end

  #TODO check if it's a manually sent msg
  def update_coversation!
    self.conversation.update_attributes(
      last_updated_by_user_id: self.sender_id,
      op_updated: (self.conversation.user_id == self.sender_id)
    )
  end

end
