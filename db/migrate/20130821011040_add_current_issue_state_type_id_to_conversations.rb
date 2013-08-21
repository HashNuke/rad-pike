class AddCurrentIssueStateTypeIdToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :current_issue_state_type_id, :integer
  end
end
