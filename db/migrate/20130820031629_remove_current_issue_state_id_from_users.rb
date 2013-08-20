class RemoveCurrentIssueStateIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :current_issue_state_id, :integer
  end
end
