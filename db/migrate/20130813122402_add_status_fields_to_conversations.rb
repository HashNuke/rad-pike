class AddStatusFieldsToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :last_updated_by_user_id, :integer
    add_column :conversations, :op_updated, :boolean
  end
end
