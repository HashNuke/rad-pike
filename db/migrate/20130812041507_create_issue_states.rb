class CreateIssueStates < ActiveRecord::Migration
  def change
    create_table :issue_states do |t|
      t.integer  :user_id
      t.integer  :issue_state_type_id

      t.timestamps
    end
  end
end
