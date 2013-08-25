class Conversation < ActiveRecord::Base
  has_many :activities, dependent: :destroy
  belongs_to :user

  has_many :issue_states, dependent: :destroy

  default_scope -> {
    #TODO I think this should just be last_message_at or last_activity_at
    includes(:user).order("last_customer_message_at DESC").limit(10)
  }

  scope :unassigned, -> { where("array_upper(current_participant_ids, 1) is ?", nil) }

  scope :having_participant, ->(participant_id) {
    where("? = ANY (current_participant_ids)", participant_id)
  }

  scope :for_user, ->(user_id) { where(user_id: user_id) }
  scope :history, ->(conversationId) { where("id < ?", conversationId) }
  scope :latest,  ->(conversationId) { where("id > ?", conversationId) }

  before_save  :ensure_properties
  before_save  :ensure_current_issue_state_type
  after_create :ensure_issue_state!

  def current_issue_state
    self.issue_states.limit(1).try(:first)
  end

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

  def ensure_current_issue_state_type
    if self.properties.respond_to?(:key?) && !self.properties.key?("current_issue_state_type_id")
      self.properties = properties_with("current_issue_state_type_id" => IssueStateType.unknown.id)
    end
  end

  def ensure_issue_state!
    self.issue_states.create
  end

end
