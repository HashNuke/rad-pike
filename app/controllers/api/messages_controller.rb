class Api::MessagesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
  end

  def create
    respond_with :api, current_user.sent_messages.create(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :message)
  end
end
