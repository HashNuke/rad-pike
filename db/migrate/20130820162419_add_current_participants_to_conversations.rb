class AddCurrentParticipantsToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :current_participant_ids, :integer, array: true, default: []
  end
end
