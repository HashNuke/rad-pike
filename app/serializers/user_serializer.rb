class UserSerializer < ActiveModel::Serializer
  attributes :id, :authentication_token, :name, :conversation

  def name
    return "Guest-#{object.id}" if object.role == "guest"
    return "Customer-#{object.id}" if object.role == "customer" && object.name.blank?
    object.name
  end


  def conversation
    object.conversations.first
  end
end
