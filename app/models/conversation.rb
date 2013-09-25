class Conversation < ActiveRecord::Base
  has_many :activities, dependent: :destroy
  belongs_to :user

  has_many :participations, dependent: :destroy

  default_scope -> {
    includes(:user).
      where("properties @> (:key => :value)", key: 'op_updated', value: true.to_s)
      order("updated_at DESC").limit(10)
  }

  scope :unassigned, -> { where("array_upper(current_participant_ids, 1) is ?", nil) }

  scope :having_participant, ->(participant_id) {
    where("? = ANY (current_participant_ids)", participant_id)
  }

  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :history, ->(conversationId) { where("id < ?", conversationId) }
  scope :latest,  ->(conversationId) { where("id > ?", conversationId) }

  before_save  :ensure_properties

  def is_for_user_id?(check_user_id)
    self.user_id == check_user_id
  end

  def ensure_properties
    self.properties ||= {}
  end

  def properties_with(new_params)
    self.properties ||= {}
    self.properties.merge(new_params)
  end

end
