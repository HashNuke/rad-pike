class CreateSettingStores < ActiveRecord::Migration
  def change
    create_table :setting_stores do |t|
      t.string :name
      t.text :value

      t.timestamps
    end
  end
end
