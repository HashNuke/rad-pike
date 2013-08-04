class Api::ChatController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def show
    message_table = Message.arel_table
    messages = Message.order("created_at DESC").
    limit(25).
    where(
      message_table[:sender_id].eq(current_user.id).
        or(message_table[:receiver_id].eq(current_user.id))
    )
    respond_with :api, messages
  end

  def create
    respond_with :api, current_user.sent_messages.create(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :message)
  end
end
