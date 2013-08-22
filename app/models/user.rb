class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable
  belongs_to  :role

  has_many :conversations,  dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :sent_activties,     class_name: "Activity", foreign_key: "sender_id"
  has_many :received_activties, class_name: "Activity", foreign_key: "receiver_id"

  scope :support_team,  -> { where(role_id: [Role.admin.id, Role.staff.id]) }
  scope :matching, ->(str) { where("name ILIKE ?", "%#{str}%") }

  before_save  :ensure_authentication_token
  after_create :ensure_conversation!, if: Proc.new{ !self.support_team? }

  def name
    return super unless super.blank?
    return "Guest-#{self.id}"    if self.guest?
    return "Customer-#{self.id}" if self.customer?
  end

  def support_team?
    self.admin? || self.staff?
  end

  def recent_conversation
    self.conversations.first
  end

  #NOTE Don't allow deactivated agents to login
  # This isn't the place to do authorization
  def active_for_authentication?
    super && !self.deactivated_staff?
  end

  def inactive_message
    self.deactivated_staff? ? :account_has_been_deactivated : super
  end

  def email_required?
    return false if self.guest? || self.deactivated_staff?
    super
  end

  #TODO right now anybody can login without an email or password
  # best bet is to disable login of guest & customer accounts
  def password_required?
    return false if self.guest? || self.customer?
    super
  end

  def ensure_conversation!
    self.conversations.create
  end

  def self.create_guest
    self.create role_id: Role.guest.id
  end

  def self.find_or_create_customer(unique_id, name)
    self.find_or_create_by_unique_id(
      unique_id,
      name:    name,
      role_id: Role.customer.id
    )
  end

  #TODO replace these with define_method
  def admin?
    self.role_id == Role.admin.id
  end

  def staff?
    self.role_id == Role.staff.id
  end

  def deactivated_staff?
    self.role_id == Role.deactivated_staff.id
  end

  def customer?
    self.role_id == Role.customer.id
  end

  def guest?
    self.role_id == Role.guest.id
  end
end
