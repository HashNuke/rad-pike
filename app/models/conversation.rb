class Conversation < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :user

  has_many :issue_states, dependent: :destroy

  default_scope -> {
    includes(:user).order("created_at DESC")
  }

  after_create :ensure_issue_state

  def current_issue_state
    self.issue_states.limit(1).try(:first)
  end

  def add_participant(user)
    if current_issue_state.participations.where(user_id: user.id).count == 0
      current_issue_state.participations.create conversation_id: self.id, user_id: user.id
    end
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
