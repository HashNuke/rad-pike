class Activity < ActiveRecord::Base

  belongs_to :conversation

  belongs_to :receiver, counter_cache: :received_activity_count,
    class_name: "User", inverse_of: :received_activities

  belongs_to :sender,   counter_cache: :sent_activity_count,
    class_name: "User", inverse_of: :sent_activities

  before_save  :ensure_activity_type

  default_scope -> {
    order("created_at DESC").limit(3)
  }

  scope :after_timestamp,  ->(activityId) { where("id > ?", activityId) }

  scope :before_timestamp, ->(activityId) { where("id < ?", activityId) }

  private

  def ensure_activity_type
    self.activity_type ||= "message"
  end
end
