class Api::ActivitiesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_conversation
  before_action :authorize_user!
  before_action :force_activity_type_for_non_staff, only: :create

  respond_to :json

  def create
    activity = current_user.sent_activities.create(activity_params)
    if current_user.support_team?
      conversation_service = ConversationService.new(@conversation)
      conversation_service.add_participant(current_user)
    end

    respond_with activity
  end

  def index
    if params[:previous_stamp]
      timestamp = DateTime.parse(params[:previous_stamp]) + 1.second
      @activities = @conversation.activities.where("created_at > ?", timestamp)
    end

    respond_with @activities
  end

  private

  def activities_params
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
