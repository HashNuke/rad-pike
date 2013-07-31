class AddCounterCacheFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sent_message_count,     :integer, default: 0
    add_column :users, :received_message_count, :integer, default: 0
  end
end
