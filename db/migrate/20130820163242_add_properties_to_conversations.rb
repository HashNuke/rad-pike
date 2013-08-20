class AddPropertiesToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :properties, :hstore
  end
end
