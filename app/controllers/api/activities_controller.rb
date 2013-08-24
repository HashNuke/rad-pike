class Api::ActivitiesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_conversation
  before_action :authorize_user!
  before_action :force_activity_type_for_non_staff, only: :create

  respond_to :json

  def create
    conversation_service = ConversationService.new(@conversation)
    activity = conversation_service.create_activity!(activity_params, current_user)
    respond_with :api, @conversation, activity
  end


  def index
    if params[:after]
      timestamp = DateTime.parse(params[:after]) + 1.second
      @activities = @conversation.activities.where("created_at > ?", timestamp)
    end

    respond_with :api, @conversation, @activities
  end


  def show
    respond_with :api, @conversation, @conversation.find_by_id!(params[:id])
  end

  private

  def activity_params
    params.require(:activity).permit(:receiver_id, :content, :conversation_id, :activity_type)
  end


  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end


  def force_activity_type_for_non_staff
    if !current_user.support_team? && params[:activity]
      params[:activity][:activity_type] = "message"
    end
  end


  def authorize_user!
    unless @conversation.is_for_user_id?(current_user.id) || current_user.support_team?
      respond_to do |format|
        format.json {render json: [], status: :unauthorized}
      end
    end
  end
end
