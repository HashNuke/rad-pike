class ConversationWithMessagesSerializer < ActiveModel::Serializer
  #TODO authentication token must not be displayed
  attributes :id, :user_id, :messages

  has_one :user

  def messages
    object.messages.order("created_at DESC").limit(25)
  end
end
