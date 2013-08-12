class IssueState < ActiveRecord::Base
  belongs_to :issue_state_type

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
end
