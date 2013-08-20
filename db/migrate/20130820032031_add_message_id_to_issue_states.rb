class AddMessageIdToIssueStates < ActiveRecord::Migration
  def change
    add_column :issue_states, :message_id, :integer
  end
end
