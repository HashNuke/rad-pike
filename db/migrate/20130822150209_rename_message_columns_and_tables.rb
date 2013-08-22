class RenameMessageColumnsAndTables < ActiveRecord::Migration
  def change
    rename_column :issue_states, :message_id, :activity_id
    rename_table  :messages, :activities
    rename_column :users, :sent_message_count, :sent_activity_count
    rename_column :users, :received_message_count, :received_activity_count
    rename_table  :registered_webhooks, :webhooks
    rename_table  :registered_webhook_events, :webhook_events
  end
end
