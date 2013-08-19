class UserSerializer < ActiveModel::Serializer
  attributes :id, :authentication_token, :name, :conversation

  def conversation
    object.conversations.first
  end
end
