class Conversation < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :user

  belongs_to :current_issue_state_type,
    class_name: 'IssueStateType',
    foreign_key: :current_issue_state_type_id

  has_many :issue_states, dependent: :destroy

  default_scope -> {
    includes(:user).order("created_at DESC")
  }

  scope :unassigned, -> { where("array_upper(current_participant_ids, 1) is ?", nil) }
  scope :having_participant, ->(participant_id) {
    where("? = ANY (current_participant_ids)", participant_id)
  }

  after_create :ensure_issue_state

  def current_issue_state
    self.issue_states.limit(1).try(:first)
  end

  def is_for_user_id?(check_user_id)
    self.user_id == check_user_id
  end

  def ensure_issue_state
    self.issue_states.create issue_state_type_id: IssueStateType.unknown
  end

  def to_indexed_json
    to_json()
  end
end
