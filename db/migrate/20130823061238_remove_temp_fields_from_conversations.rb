class RemoveTempFieldsFromConversations < ActiveRecord::Migration
  def change
    remove_column :conversations, :last_updated_by_user_id, :string
    remove_column :conversations, :op_updated, :string
    remove_column :conversations, :current_issue_state_type_id, :string
  end
end
