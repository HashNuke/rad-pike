class RegisteredWebhookEvent < ActiveRecord::Base
  belongs_to :registered_webhook
  belongs_to :webhook_event
end
