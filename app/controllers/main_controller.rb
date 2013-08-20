class MainController < ApplicationController

  before_action :authenticate_user!
  before_action :set_broadcaster_host

  def index
  end

  def authenticate_user!
    super
    unless current_user.admin? || current_user.staff?
      sign_out :user
      #TODO respond based on request type
      redirect_to new_user_session_path
    end
  end
end
