class AddCurrentIssueStateIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_issue_state_id, :integer
  end
end
