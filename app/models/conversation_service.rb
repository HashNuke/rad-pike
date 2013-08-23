class ConversationService

  def initialize(conversation)
    @conversation = conversation
  end

  def create_activity!(activity_params, user)
    activity = user.sent_activities.create!(activity_params)
    after_activity_create(activity)
  end

  def change_state!(state_type, user)
    if @conversation.current_issue_state.unknown_state?
      change_state_from_unknown!(state_type, user)
      return
    end

    new_issue_state = @conversation.issue_states.create(
      issue_state_type_id: IssueStateType.send(state_type).id,
      user_id: user.id
    )

    new_issue_state.participations.create(user_id: user.id)
    @conversation.update_attributes(
      current_participant_ids: new_issue_state.participations.pluck(:user_id),
      current_issue_state_type_id: new_issue_state.issue_state_type_id
    )
  end


  private

  def add_participant!(user, update_participant_list=false)
    if !@conversation.current_participant_ids.include?(user.id)
      @conversation.
        current_issue_state.
        participations.create(user_id: user.id)
    end
    if update_participant_list
      @conversation.update_attributes(current_participant_ids: updated_participant_list)
    end
  end


  def after_activity_create(activity)
    conversation_params = properties_after_activity_create(activity)

    if user.support_team?
      add_participant!(user, conversation_params)
      conversation_params.merge!(current_participant_ids: updated_participant_list)
    else
      conversation_params.merge!(last_customer_message_at: DateTime.now)
    end

    @conversation.update_attributes(conversation_params)
  end


  def properties_after_activity_create(activity)
    {
      properties: {
        last_updated_by_user_id: activity.sender_id,
        op_updated: (@conversation.user_id == activity.sender_id)
      }
    }
  end


  def updated_participant_list
    @conversation.current_issue_state.
      participations.pluck(:user_id).compact.uniq
  end


  def change_state_from_unknown!(state_type, user)
    @conversation.current_issue_state.update_attributes(
      issue_state_type_id: IssueStateType.send(state_type).id,
      user_id: user.id
    )

    add_participant!(user)
    update_params = { current_issue_state_type_id: IssueStateType.send(state_type).id }

    unless @conversation.current_participant_ids.include?(user.id)
      update_params[:current_participant_ids] = updated_participant_list
    end
    @conversation.update_attributes(update_params)
  end

end
