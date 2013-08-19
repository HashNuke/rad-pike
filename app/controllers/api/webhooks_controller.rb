class Api::WebhooksController < ApplicationController
  respond_to :json, :html
  before_action :authenticate_user!

  layout 'manage'

  def index
    @webhooks = RegisteredWebhook.all
  end

  def new
    @webhook = RegisteredWebhook.new
  end

  def create
    @webhook = RegisteredWebhook.create webhook_params
    respond_with @webhook, location: api_webhooks_path
  end

  def destroy
    RegisteredWebhook.destroy(params[:id])
  end

  private

  def webhook_params
    params.require(:registered_webhook).permit(:name, :url)
  end

  def authenticate_user!
    super
    redirect_to root_path unless current_user.admin?
  end
end