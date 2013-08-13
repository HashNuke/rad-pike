class CreateRegisteredWebhookEvents < ActiveRecord::Migration
  def change
    create_table :registered_webhook_events do |t|
      t.integer :registered_webhook_id
      t.integer :webhook_event_id

      t.timestamps
    end
  end
end
