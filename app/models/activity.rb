class Activity < ActiveRecord::Base

  belongs_to :conversation

  belongs_to :receiver, counter_cache: :received_activity_count,
    class_name: "User", inverse_of: :received_activities

  belongs_to :sender,   counter_cache: :sent_activity_count,
    class_name: "User", inverse_of: :sent_activities

  before_save  :ensure_activity_type

  private

  def ensure_activity_type
    self.ensure_activity_type ||= "message"
  end
end
