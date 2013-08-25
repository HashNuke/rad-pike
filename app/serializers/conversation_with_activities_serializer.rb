class ConversationWithActivitiesSerializer < ActiveModel::Serializer
  attributes :id, :attrs

  has_one  :user, serializer: PublicUserSerializer
  has_many :activities


  def activities
    if @options[:query_options].key?(:after)
      object.activities.latest(@options[:query_options][:activityId]).reverse
    elsif @options[:query_options].key?(:before)
      object.activities.history(@options[:query_options][:activityId]).reverse
    else
      object.activities.reverse
    end
  end


  def attrs
    {
      current_issue_state_type: current_issue_state_type,
      created_at: object.created_at,
      updated_at: object.updated_at
    }
  end


  def current_issue_state_type
    IssueStateType.find(object.properties["current_issue_state_type_id"]).name
  end
end
