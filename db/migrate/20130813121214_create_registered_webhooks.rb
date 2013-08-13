class CreateRegisteredWebhooks < ActiveRecord::Migration
  def change
    create_table :registered_webhooks do |t|
      t.string :name
      t.text :url
      t.boolean :active

      t.timestamps
    end
  end
end
