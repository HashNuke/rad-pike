class Message < ActiveRecord::Base

  belongs_to :recipient, counter_cache: :received_message_count,
    inverse_of: :received_messages

  belongs_to :sender,    counter_cache: :sent_message_count,
    inverse_of: :sent_messages

end
