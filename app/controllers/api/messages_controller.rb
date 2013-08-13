class Api::MessagesController < ApplicationController
  before_action :authenticate_user!, except: :user_conversation

  before_action :set_conversation, only: [:create, :show]
  before_action :set_conversation_for_user, only: :user_conversation
  respond_to :json


  def index
    respond_with :api, Conversation.all
  end

  def show
    respond_with :api, @conversation, serializer: ConversationWithMessagesSerializer
  end

  def user_conversation
    respond_with :api, @conversation, serializer: ConversationWithMessagesSerializer
  end

  def create
    respond_with :api, current_user.sent_messages.create(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :content, :conversation_id)
  end

  def set_conversation
    @conversation = Conversation.find(params[:id] || params[:message][:conversation_id])
  end

  def set_conversation_for_user
    @user = User.includes(:conversations)find(params[:id])
    @conversation = @user.try(:conversations).try(:first)
  end
end
