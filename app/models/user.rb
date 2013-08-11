class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  before_save :ensure_authentication_token

  has_many :sent_messages,     class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "receiver_id"

  scope :support_team, -> { where(role: ["admin", "staff"]) }

  def email_required?
    return false if self.role == "guest" || self.role == "deactivated-agent"
    super
  end

  #TODO right now anybody can login without an email or password
  # best bet is to disable login of guest & customer accounts
  def password_required?
    return false if ["guest", "customer"].include?(self.role)
    super
  end

end
