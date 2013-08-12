class CreateIssueStateTypes < ActiveRecord::Migration
  def change
    create_table :issue_state_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
