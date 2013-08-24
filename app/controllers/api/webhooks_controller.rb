class Api::WebhooksController < ApplicationController
  respond_to :json, :html
  before_action :authenticate_user!
  before_action :authorize_user!

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

  def authorize_user!
    not_authorized unless current_user.admin?
  end
end