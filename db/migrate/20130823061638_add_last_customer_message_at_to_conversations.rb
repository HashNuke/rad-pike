class AddLastCustomerMessageAtToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :last_customer_message_at, :datetime
  end
end
