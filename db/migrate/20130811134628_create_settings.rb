class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string  :name
      t.text    :value
      t.boolean :options_available, default: false
      t.integer :selected_setting_id

      t.timestamps
    end
  end
end
