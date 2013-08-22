class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :activity_type

  has_one :sender,   serializer: PublicUserSerializer
  has_one :receiver, serializer: PublicUserSerializer
end
