class ConversationWithMessagesSerializer < ActiveModel::Serializer
  #TODO authentication token must not be displayed
  attributes :id, :user_id, :messages, :created_at

  has_one  :user, serializer: PublicUserSerializer
  has_many :messages
  has_one  :current_issue_state_type
end
