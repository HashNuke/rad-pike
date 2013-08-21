class MessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at

  #TODO write a diff serializer. Else everybody's auth tokens will be out in the open
  has_one :sender,   serializer: PublicUserSerializer
  has_one :receiver, serializer: PublicUserSerializer

end
