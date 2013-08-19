class RegisteredWebhook < ActiveRecord::Base
  has_many :registered_webhook_events
end
