class RegisteredWebhook < ActiveRecord::Base
  has_many :registered_webhook_events

  validates :name, presence: true, length: { minimum: 3 }
  validates :url,  format: {
      with: /\Ahttp\:s?\/\/.+\z/,
      message: "should start with http:// or https:// and should be valid"
    }
end
