class Api::ConversationsController < ApplicationController
  respond_to :json

  before_action :find_or_create_user_for_embed,  only: :user_conversation
  before_action :sign_in_user_from_embed,        only: :user_conversation
  before_action :set_conversation_for_embed,     only: :user_conversation
  before_action :authenticate_user!
  before_action :set_conversation,               only: [:create_message, :show, :update]

  #TODO to query messages, latest, unread/read
  def index
    if params[:filter] == "all" || params["filter"].blank?
      @conversations = Conversation.all
    elsif params[:filter] == "unassigned"
      @conversations = Conversation.unassigned
    else
      @conversations = Conversation.having_participant(params[:filter])
    end
    respond_with :api, @conversations
  end

  def show
    respond_with :api, @conversation, serializer: ConversationWithMessagesSerializer
  end

  def update
    conversation_service = ConversationService.new(@conversation)
    conversation_service.change_state(conversation_params[:state_type], current_user)
    respond_with(@conversation)
  end

  def user_conversation
    respond_to do |format|
      format.json {
        render json: @conversation, serializer: ConversationWithMessagesSerializer
      }
    end
  end


  private

  def conversation_params
    params.require(:conversation).permit(:state_type)
  end

  def set_conversation
    @conversation = Conversation.find(params[:id])
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
