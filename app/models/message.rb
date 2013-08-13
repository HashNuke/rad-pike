class Message < ActiveRecord::Base

  belongs_to :conversation

  belongs_to :receiver, counter_cache: :received_message_count,
    class_name: "User", inverse_of: :received_messages

  belongs_to :sender,   counter_cache: :sent_message_count,
    class_name: "User", inverse_of: :sent_messages

  after_create :broadcast

  def broadcast
    Broadcaster.broadcast(self)
  end
end
