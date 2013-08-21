class ConversationWithMessagesSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at

  has_one  :user, serializer: PublicUserSerializer
  has_one  :current_issue_state_type
  has_many :messages
end
