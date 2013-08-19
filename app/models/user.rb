class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  before_save :ensure_authentication_token
  belongs_to  :role

  has_many   :conversations,       dependent: :destroy
  has_many   :sent_messages,       class_name: "Message", foreign_key: "sender_id"
  has_many   :received_messages,   class_name: "Message", foreign_key: "receiver_id"
  belongs_to :current_issue_state, class_name: "IssueState"

  scope :support_team, -> { where(role_id: [Role.admin.id, Role.staff.id]) }


  after_create(:ensure_conversation!,
    if: Proc.new{ self.customer? || self.guest? })

  has_many :participations, dependent: :destroy

  # Don't allow deactivated agents to login
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

  def ensure_authentication_token
    super if self.admin? || self.staff?
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
