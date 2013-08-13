class Api::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:create, :show]
  respond_to :json

  def index
    respond_with :api, Conversation.all
  end

  def show
    respond_with :api, @conversation, serializer: ConversationWithMessagesSerializer
  end

  def create
    respond_with :api, current_user.sent_messages.create(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :message)
  end

  def set_conversation
    @conversation = Conversation.find(params[:id] || params[:message][:conversation_id])
  end
end
