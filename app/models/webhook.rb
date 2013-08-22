class Webhook < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3 }
  validates :url,  format: {
      with: /\Ahttp\:s?\/\/.+\z/,
      message: "should start with http:// or https:// and should be valid"
    }
end
