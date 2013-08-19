class AddUniqueIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unique_id, :string
  end
end
