class ConversationService
  def initialize(conversation)
    @conversation = conversation
  end


  def change_state(state_type, user)    
    if @conversation.current_issue_state.unknown_state?
      change_state_from_unknown(state_type, user)
      return
    end

    new_issue_state = @conversation.issue_states.create(
      issue_state_type_id: IssueStateType.send(state_type).id,
      user_id: user.id
    )

    new_issue_state.participations.create(user_id: user)
    @conversation.update_attributes(
      current_participant_ids: new_issue_state.participations.pluck(:user_id),
      current_issue_state_type_id: new_issue_state.issue_state_type_id
    )
  end


  def add_participant(user)
    if user.support_team? && !current_participants.include?(user.id)
      @conversation.
        current_issue_state.
        participations.create(conversation_id: @conversation.id, user_id: user.id)

      @conversation.update_attributes(
        current_participant_ids: @conversation.current_participant_ids.push(user.id)
      )
    end
  end


  private

  def change_state_from_unknown(state_type, user)
    @conversation.current_issue_state.update_attributes(
      issue_state_type_id: IssueStateType.send(state_type).id,
      user_id: user.id
    )
    update_params = { current_issue_state_type_id: IssueStateType.send(state_type).id }
    unless @conversation.current_participant_ids.include?(user.id)
      update_params[:current_participant_ids] = @conversation.current_participant_ids.push(user.id)
    end
    @conversation.update_attributes(update_params)
  end


  def current_participations
    @conversation.current_participant_ids
  end

end
