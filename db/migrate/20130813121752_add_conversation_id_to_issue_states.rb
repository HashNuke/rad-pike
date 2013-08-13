class AddConversationIdToIssueStates < ActiveRecord::Migration
  def change
    add_column :issue_states, :conversation_id, :integer
  end
end
