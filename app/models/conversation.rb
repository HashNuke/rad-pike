class Conversation < ActiveRecord::Base
  has_many :activities, dependent: :destroy
  belongs_to :user

  belongs_to :current_issue_state_type,
    class_name: 'IssueStateType',
    foreign_key: :current_issue_state_type_id

  has_many :issue_states, dependent: :destroy

  default_scope -> {
    includes(:user).order("last_customer_message_at DESC")
  }

  scope :unassigned, -> { where("array_upper(current_participant_ids, 1) is ?", nil) }
  scope :having_participant, ->(participant_id) {
    where("? = ANY (current_participant_ids)", participant_id)
  }

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
    self.properties = properties_with(current_issue_state_type_id: IssueStateType.unknown.id)
  end

  def ensure_issue_state!
    self.issue_states.create
  end

end
