class AddPropertiesIndexForConversations < ActiveRecord::Migration
  def change
    execute("CREATE INDEX conversations_gin_properties ON conversations USING GIN(properties)")
  end
end
