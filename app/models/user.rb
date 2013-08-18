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

  scope :support_team, -> { where(role: ["admin", "staff"]) }


  after_create(:ensure_current_issue_state!,
    if: Proc.new{ ["guest", "customer"].include?(self.role) })

  after_create(:ensure_conversation!,
    if: Proc.new{ ["guest", "customer"].include?(self.role) })

  has_many :issue_states,   dependent: :destroy
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

  def ensure_current_issue_state!
    issue_state = self.issue_states.create(issue_state_type_id: IssueStateType.unresolved.id)
    self.update_attribute :current_issue_state_id, issue_state.id
  end

  def ensure_conversation!
    self.conversation.create
  end

  [:admin, :staff, :deactivated_staff, :customer, :guest].each do |role_method|
    define_method "#{role_method}?" do
      self.role_id == Role.send(role_method).id
    end
  end
end
