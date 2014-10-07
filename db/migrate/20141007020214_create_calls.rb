class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.string :cell_phone
      t.text :call_reminder

      t.timestamps
    end
  end
end
