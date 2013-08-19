class CreateSettingOptions < ActiveRecord::Migration
  def change
    create_table :setting_options do |t|
      t.text    :name
      t.integer :setting_id

      t.timestamps
    end
  end
end
