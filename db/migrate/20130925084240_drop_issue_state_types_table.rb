class DropIssueStateTypesTable < ActiveRecord::Migration
  def up
    drop_table :issue_state_types
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
