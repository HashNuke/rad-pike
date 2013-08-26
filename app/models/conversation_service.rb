class ConversationService

  def initialize(conversation)
    @conversation = conversation
  end


  def create_activity!(activity_params, user)
    activity = user.sent_activities.create!(activity_params)
    after_activity_create(activity, user)
    return activity
  end


  def change_state!(state_type, user)
    issue_state_type = IssueStateType.send(state_type)
    issue_state = create_or_build_issue_state(issue_state_type)
    issue_state.user_id = user.id
    issue_state.save!
    add_participant_to_issue_state!(user, issue_state)

    @conversation.current_participant_ids = participant_ids_for_issue_state(issue_state)
    @conversation.properties = @conversation.
      properties_with("current_issue_state_type_id" => issue_state_type.id)
    @conversation.save!
    @conversation
  end


  private

  def create_or_build_issue_state(issue_state_type)
    @conversation.current_issue_state if @conversation.current_issue_state.unknown_state?
    @conversation.issue_states.build(issue_state_type_id: issue_state_type.id)
  end


  def add_participant_to_issue_state!(user, issue_state)
    issue_state.participations.create!(user_id: user.id)
  end


  def after_activity_create(activity, user)
    conversation_params = {}
    conversation_properties = properties_after_activity_create(activity)
    conversation_properties["activities_count"] = 1 + @conversation.properties["activities_count"].to_i

    if user.support_team?
      add_participant_to_issue_state!(user, @conversation.current_issue_state)
      conversation_properties["current_participant_ids"] = participant_ids_for_issue_state(@conversation.current_issue_state)
    else
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
      "op_updated" => (@conversation.user_id == activity.sender_id)
    }
  end


  def participant_ids_for_issue_state(issue_state)
    issue_state.participations.pluck(:user_id).compact.uniq
  end

end
