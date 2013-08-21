class ConversationSerializer < ActiveModel::Serializer
  #TODO authentication token must not be displayed
  #TOOD make sure update is touched whenever the conversation is updated
  attributes :id, :user_id, :updated_at, :created_at

  has_one :current_issue_state_type
  has_one :user,  serializer: PublicUserSerializer
end
