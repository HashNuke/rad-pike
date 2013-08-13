class AddConversationIdToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :conversation_id, :integer
  end
end
