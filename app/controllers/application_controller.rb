class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  protected

  def not_authorized
    redirect_to root_path
  end

  def layout_by_resource
    return "manage" if devise_controller?
    "application"
  end
end
