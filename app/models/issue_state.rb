class IssueState < ActiveRecord::Base
  belongs_to :issue_state_type
  has_many   :participations, dependent: :destroy
  belongs_to :conversation

  default_scope -> {
    order("created_at DESC")
  }

  #NOTE cache issue state type. There must be only a few anyway
  def issue_state_type
    issue_type = Rails.cache.fetch('issue-state-type-#{self.issue_state_type_id}')
    return issue_type if issue_type

    issue_type = super
    if issue_type
      Rails.cache.write('issue-state-type-#{self.issue_state_type_id}', issue_type)
    end
    issue_type
  end

  def resolved_state?
    self.issue_state_type_id == IssueStateType.resolved.id
  end

  def unresolved_state?
    self.issue_state_type_id == IssueStateType.unresolved.id
  end

  def unknown_state?
    self.issue_state_type_id == IssueStateType.unknown.id
  end
end
