class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :destroy]

  layout 'manage'

  def index
    @users = User.support_team
  end

  def new
    @user = User.new role: "agent"
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to members_path, notice: "The user has been added."
    else
      render 'edit'
    end
  end

  def edit
  end

  def update
    @user = User.new user_params
    if @user.save
      redirect_to members_path, notice: "The user has been updated."
    else
      render 'edit'
    end
  end

  def destroy
    msg = {error: "The user could not be deleted ~!"}
    if @user
      @user.update_attributes role: "deactivated-agent", email: ""
      msg = {notice: "The user has been deleted."}
    end
    redirect_to members_path, msg
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end