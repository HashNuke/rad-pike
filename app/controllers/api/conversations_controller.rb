class Api::ConversationsController < ApplicationController
  respond_to :json

  before_action :set_user_by_find_or_create, only: [:show, :user_conversation]
  before_action :authenticate_user!, except: :user_conversation
  before_action :set_conversation,   only: [:show, :update, :user_conversation]
  before_action :set_query_options,  only: [:show, :user_conversation]
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


  def user_conversation
    respond_to do |format|
      format.json {
        render(json: @conversation, serializer: ConversationWithActivitiesSerializer)
      }
    end
  end


  def show
    respond_to do |format|
      format.json {
        render(
          json: @conversation,
          serializer: ConversationWithActivitiesSerializer,
          query_options: @query_options
        )
      }
    end
  end


  private

  def conversation_params
    params.require(:conversation).permit(:state_type)
  end


  def set_conversation
    if !params[:id].blank? && @user.support_team?
      @conversation = Conversation.find_by_id!(params[:id])
      return
    end
    @conversation = @user.recent_conversation
  end


  def set_user_by_find_or_create
    @user = warden.authenticate(scope: :user)
    return if @user

    if !params[:unique_user_id].blank? && !params[:user_name].blank?
      @user = User.find_or_create_customer(params[:unique_user_id], params[:user_name])
      sign_in @user
    else
      @user = User.create_guest
      sign_in @user
    end

    puts "*"*10
    puts @user.inspect
    puts "*"*10
  end


  def set_query_options
    @query_options = {}
    @query_options[:after]  = params[:after]  if params[:after]
    @query_options[:before] = params[:before] if params[:before]
    @query_options[:activityId] = params[:activityId] if params[:activityId]
  end


  def authorize_user!
    return if current_user.support_team?
    return if @user && ["user_conversation", "show"].include?(params[:action])
    puts "REDIRECTING"
    puts params[:action]
    puts @user.inspect
    not_authorized
  end
end
