class MessageSerializer < ActiveModel::Serializer
  attributes :id

  #TODO write a diff serializer. Else everybody's auth tokens will be out in the open
  has_one :sender, serializer: UserSerializer
  has_one :receiver
end
