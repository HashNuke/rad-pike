class Conversation < ActiveRecord::Base
  has_many :messages, dependent: :destroy
  belongs_to :user

  has_many :issue_states, dependent: :destroy

  default_scope -> {
    includes(:user).order("created_at DESC")
  }

  before_save :ensure_token!

  def is_for_user_id?(check_user_id)
    self.user_id == check_user_id
  end

  def ensure_token!
    self.token ||= SecureRandom.hex(3)
  end

  def to_indexed_json
    to_json()
  end
end
