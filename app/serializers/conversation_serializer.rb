class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :current_issue_state_type, :created_at, :updated_at

  has_one :user, serializer: PublicUserSerializer

  def current_issue_state_type
    IssueStateType.find(object.properties["current_issue_state_type_id"]).name
  end
end
