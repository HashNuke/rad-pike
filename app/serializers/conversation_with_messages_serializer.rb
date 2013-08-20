class ConversationWithMessagesSerializer < ActiveModel::Serializer
  #TODO authentication token must not be displayed
  attributes :id, :user_id, :token, :messages

  has_one  :user
  has_many :messages

end
