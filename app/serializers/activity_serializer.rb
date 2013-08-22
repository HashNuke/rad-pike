class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at

  has_one :sender,   serializer: PublicUserSerializer
  has_one :receiver, serializer: PublicUserSerializer
end
