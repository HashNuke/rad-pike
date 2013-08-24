class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!
  before_action :set_user, only: [:edit, :update, :destroy]
  respond_to :json, :html

  layout 'manage'

  def index
    @users = User.support_team
  end

  def search
    @users = User.support_team.matching(params[:query])
    respond_with @users
  end

  def new
    @user = User.new role_id: Role.staff.id
  end

  def create
    @user = User.new user_params
    if @user.save
      respond_with @user, location: members_path, notice: "The user has been added."
    else
      respond_with @user
    end
  end

  def edit
  end

  def update
    updatable_params = user_params
    if updatable_params[:password].blank? && updatable_params[:password_confirmation].blank?
      updatable_params.delete(:password)
      updatable_params.delete(:password_confirmation)
    end

    if @user.update_attributes updatable_params
      flash[:notice] = "The user has been updated."
      respond_with @user, location: members_path
    else
      respond_with @user
    end
  end

  def destroy
    if @user
      @user.update_attributes role: "deactivated-agent", email: ""
      flash[:notice] = "The user has been deleted."
    else
      flash[:error] = "The user could not be deleted ~!"
    end

    respond_to do |format|
      format.json {head :ok}
      format.html {redirect_to members_path}
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :role_id)
  end

  def set_user
    @user = User.find_by_id!(params[:id])
  end

  def authorize_user!
    return if current_user.id == params[:id]
    return if current_user.admin?
    not_authorized
  end
end