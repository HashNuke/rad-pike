class Message < ActiveRecord::Base

  belongs_to :receiver, counter_cache: :received_message_count,
    class_name: "User", inverse_of: :received_messages

  belongs_to :sender,   counter_cache: :sent_message_count,
    class_name: "User", inverse_of: :sent_messages

  scope :conversations, -> {
    includes(:sender).limit(25).order(:created_at)
  }
end
