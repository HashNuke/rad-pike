class Api::ConversationsController < ApplicationController
  respond_to :json

  before_action :set_user_by_find_or_create, only: :user_conversation
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show, :user_conversation, :update]
  before_action :authorize_user!

  #TODO to query activities, latest, unread/read
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


  def update
    conversation_service = ConversationService.new(@conversation)
    @conversation = conversation_service.change_state!(conversation_params[:state_type], current_user)
    respond_to do |format|
      format.json {render json: @conversation }
    end
  end


  def show
    respond_to do |format|
      format.json {
        render json: @conversation, serializer: ConversationWithActivitiesSerializer
      }
    end
  end

  alias_method :user_conversation, :show

  private

  def conversation_params
    params.require(:conversation).permit(:state_type)
  end


  def set_conversation
    return (@conversation = Conversation.find_by_id!(params[:id])) if params[:id]

    #NOTE incase the id isn't available as in the case of the embed widget
    @conversation = @user.recent_conversation
  end


  def set_user_by_find_or_create
    return (@user = current_user) if user_signed_in?

    if !params[:unique_user_id].blank? && !params[:user_name].blank?
      @user = User.find_or_create_customer(params[:unique_user_id], params[:user_name])
      sign_in @user
    else
      @user = User.create_guest
      sign_in @user
    end
  end


  def authorize_user!
    return if params[:action] == "user_conversation"
    return if current_user.support_team?
    not_authorized
  end
end
