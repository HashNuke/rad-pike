class RemoveUserIdFromIssueStatesAndParticipations < ActiveRecord::Migration
  def change
    remove_column :participations, :user_id, :integer
    remove_column :issue_states,   :user_id, :integer
  end
end
