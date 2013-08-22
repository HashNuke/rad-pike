class Api::ActivitiesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_conversation
  before_action :authorize_user!

  def create
    activity = current_user.sent_activities.create(activity_params)
    if current_user.support_team?
      conversation_service = ConversationService.new(@conversation)
      conversation_service.add_participant(current_user)
    end

    respond_to do |format|
     format.json { render json: activity }
    end
  end

  def index
    if params[:previous_stamp]
      timestamp = DateTime.parse(params[:previous_stamp]) + 1.second
      @activities = @conversation.activities.where("created_at > ?", timestamp)
    end

    respond_to do |format|
      format.json { render json: @activities || [] }
    end
  end

  private

  def activities_params
    params.require(:activity).permit(:receiver_id, :content, :conversation_id)
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def authorize_user!
    unless @conversation.is_for_user_id?(current_user.id) || current_user.support_team?
      respond_to do |format|
        format.json {render json: [], status: :unauthorized}
      end
    end
  end
end
