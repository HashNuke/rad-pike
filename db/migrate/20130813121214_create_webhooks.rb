class CreateWebhooks < ActiveRecord::Migration
  def change
    create_table :webhooks do |t|
      t.string :name
      t.text :url
      t.boolean :active

      t.timestamps
    end
  end
end
