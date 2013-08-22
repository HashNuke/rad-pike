class Activity < ActiveRecord::Base

  belongs_to :conversation

  belongs_to :receiver, counter_cache: :received_activity_count,
    class_name: "User", inverse_of: :received_activities

  belongs_to :sender,   counter_cache: :sent_activity_count,
    class_name: "User", inverse_of: :sent_activities

  after_create :update_conversation!

  #TODO check if it's a manually sent msg
  def update_conversation!
    self.conversation.update_attributes(
      last_updated_by_user_id: self.sender_id,
      op_updated: (self.conversation.user_id == self.sender_id)
    )
  end

end