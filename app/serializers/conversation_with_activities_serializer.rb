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
      created_at: object.created_at,
      updated_at: object.updated_at,
      last_message_at: object.properties["last_message_at"],
      activities_count: object.properties["activities_count"],
      messages_count: object.properties["messages_count"]
    }
  end

end
