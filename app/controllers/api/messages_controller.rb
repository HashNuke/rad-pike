class Api::MessagesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_conversation
  before_action :authorize_user!

  def create
    message = current_user.sent_messages.build(message_params)
    Broadcaster.broadcast(request.host, message) if message.save
    #TODO respond appropriately
    respond_to do |format|
     format.json { render json: message }
   end
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :content, :conversation_id)
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