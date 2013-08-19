class Api::MessagesController < ApplicationController
  respond_to :json

  before_action :find_or_create_user_for_embed,  only: :user_conversation
  before_action :sign_in_user_from_embed,        only: :user_conversation
  before_action :set_conversation_for_embed,     only: :user_conversation
  before_action :authenticate_user!
  before_action :set_conversation,               only: [:create, :show]

  #TODO to query messages, latest, unread/read
  def index
    respond_with :api, Conversation.all
  end

  def show
    respond_with :api, @conversation, serializer: ConversationWithMessagesSerializer
  end

  def user_conversation
    respond_to do |format|
      format.json {
        render json: @conversation, serializer: ConversationWithMessagesSerializer
      }
    end
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

  def set_conversation_for_embed
    @conversation = @user.try(:conversations).try(:first)
  end

  def find_or_create_user_for_embed
    if !params[:unique_user_id].blank? && !params[:user_name].blank?
      @user = User.find_or_create_customer(params[:unique_user_id], params[:user_name])
    else
      @user = User.create_guest
    end
  end

  def sign_in_user_from_embed
    sign_in @user if @user
  end
end
