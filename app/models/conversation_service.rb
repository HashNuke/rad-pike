class ConversationService

  def initialize(conversation)
    @conversation = conversation
  end


  def create_activity!(activity_params, user)
    activity = user.sent_activities.create!(activity_params)
    after_activity_create(activity, user)
    return activity
  end


  private

  def after_activity_create(activity, user)
    conversation_params = {}
    conversation_properties = properties_after_activity_create(activity)
    conversation_properties["activities_count"] = 1 + @conversation.properties["activities_count"].to_i

    unless user.support_team?
      conversation_properties["last_customer_message_at"] = DateTime.now
    end

    if activity.activity_type == "message"
      conversation_properties["messages_count"] = 1 + @conversation.properties["messages_count"].to_i
    end

    conversation_properties = @conversation.properties_with(conversation_properties)
    @conversation.update_attributes(conversation_params.merge({properties: conversation_properties}))
  end


  def properties_after_activity_create(activity)
    {
      "last_updated_by_user_id" => activity.sender_id,
      "op_updated" => (
        @conversation.user_id == activity.sender_id && activity.activity_type == "message"
      )
    }
  end


end
