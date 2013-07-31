class Api::UsersController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json

  def show
    respond_with :api, User.find(params[:id])
  end

end