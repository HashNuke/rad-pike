class Conversation < ActiveRecord::Base
  has_many   :messages, dependent: :destroy
  belongs_to :user

  default_scope -> {
    includes(:user).order("created_at DESC")
  }
end
