class Api::ConversationsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def index
    respond_with :api, Message.conversations
  end
end
