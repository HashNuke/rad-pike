class Participation < ActiveRecord::Base
  belongs_to :issue_state
  belongs_to :conversation
  belongs_to :user
end