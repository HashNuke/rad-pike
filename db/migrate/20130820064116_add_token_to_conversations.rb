class AddTokenToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :token, :string
  end
end
