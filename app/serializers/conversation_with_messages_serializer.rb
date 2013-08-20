class ConversationWithMessagesSerializer < ActiveModel::Serializer
  #TODO authentication token must not be displayed
  attributes :id, :user_id, :messages, :created_at

  has_one  :user
  has_many :messages

end
