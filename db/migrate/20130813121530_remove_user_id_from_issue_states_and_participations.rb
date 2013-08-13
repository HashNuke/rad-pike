class RemoveUserIdFromIssueStatesAndParticipations < ActiveRecord::Migration
  def change
    remove_column :participations, :user_id
    remove_column :issue_states,   :user_id
  end
end
