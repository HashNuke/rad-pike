class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  def set_broadcaster_host
    @broadcaster_host = "http://#{request.host}:#{AppConfig.values["faye"]["port"]}"
  end

  protected

  def layout_by_resource
    return "manage" if devise_controller?
    "application"
  end
end
