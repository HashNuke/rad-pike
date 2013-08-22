class Api::WebhooksController < ApplicationController
  respond_to :json, :html
  before_action :authenticate_user!

  layout 'manage'

  def index
    @webhooks = Webhook.all
  end

  def new
    @webhook = Webhook.new
  end

  def create
    @webhook = Webhook.create webhook_params
    respond_with @webhook, location: api_webhooks_path
  end

  def destroy
    Webhook.destroy(params[:id])
  end

  private

  def webhook_params
    params.require(:webhook).permit(:name, :url)
  end

  def authenticate_user!
    super
    redirect_to root_path unless current_user.admin?
  end
end