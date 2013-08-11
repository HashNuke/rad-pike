class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.staff
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
    if @user.save
      redirect_to members_path
    else
      render 'edit'
    end
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
    if @user
      @user.update_attributes role: "deactivated-agent", email: ""
    end
    redirect_to members_path, notice: "The user has been deleted."
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end