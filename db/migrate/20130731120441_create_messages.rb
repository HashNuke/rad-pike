class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :recipient_id
      t.integer :sender_id

      t.timestamps
    end
  end
end
