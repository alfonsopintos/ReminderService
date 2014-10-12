class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :cell_phone
      t.text :text_reminder
      t.references :event_recurrence, index: true
    end
  end
end
