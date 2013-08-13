class CreateWebhookEvents < ActiveRecord::Migration
  def change
    create_table :webhook_events do |t|
      t.string :name

      t.timestamps
    end
  end
end
