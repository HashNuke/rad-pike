class Participations < ActiveRecord::Base
  belongs_to :issue_state
  belongs_to :user
end