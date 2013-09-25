class DropIssueStatesTable < ActiveRecord::Migration
  def up
    drop_table :issue_states
    remove_column :participations, :issue_state_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
