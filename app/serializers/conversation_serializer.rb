class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at

  has_one :user, serializer: PublicUserSerializer
end
