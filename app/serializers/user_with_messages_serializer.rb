class UserWithMessagesSerializer < UserSerializer
  attributes :id, :authentication_token, :messages

  def messages
    Message.limit(30).
      where("sender_id = :user_id OR recipient_id = :user_id", {user_id: object.id})
  end
end
