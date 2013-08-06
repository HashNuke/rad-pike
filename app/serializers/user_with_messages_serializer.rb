class UserWithMessagesSerializer < UserSerializer
  #TODO authentication token must not be displayed
  attributes :id, :messages

  def messages
    message_table = Message.arel_table
    messages = Message.order("created_at DESC").
    limit(25).
    where(
      message_table[:sender_id].eq(object.id).
        or(message_table[:receiver_id].eq(object.id))
    )
  end
end
