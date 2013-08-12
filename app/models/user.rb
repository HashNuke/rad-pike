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
  belongs_to :current_issue_state, class_name: "IssueState"

  scope :support_team, -> { where(role: ["admin", "staff"]) }

  after_create(:ensure_current_issue_state!,
    if: Proc.new{ ["guest", "customer"].include?(self.role) })

  has_many :issue_states, dependent: :destroy
  has_many :participations, dependent: :destroy

  # Don't allow deactivated agents to login
  def active_for_authentication?
    super && self.role != "deactivated-agent"
  end

  def inactive_message
    (self.role != "deactivated-agent") ? super : :account_has_been_deactivated
  end

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

  def ensure_current_issue_state!
    issue_state = self.issue_states.create(issue_state_type_id: IssueStateType.unresolved.id)
    self.update_attribute :current_issue_state_id, issue_state.id
  end
end
