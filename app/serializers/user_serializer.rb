class UserSerializer < ActiveModel::Serializer
  attributes :id, :display_name, :authentication_token
end
