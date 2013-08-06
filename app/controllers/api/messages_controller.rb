class Api::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :show
  respond_to :json

  def index
    respond_with :api, Message.conversations
  end

  def show
    respond_with :api, @user, serializer: UserWithMessagesSerializer
  end

  def create
    respond_with :api, current_user.sent_messages.create(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :message)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
