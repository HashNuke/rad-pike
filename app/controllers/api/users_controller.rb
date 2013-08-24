class Api::UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def show
    respond_with :api, @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user!
    return if current_user.admin?
    return if current_user.support_staff? && params[:action] == "show"
    not_authorized
  end
end
