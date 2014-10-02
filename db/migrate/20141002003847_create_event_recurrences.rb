class CreateEventRecurrences < ActiveRecord::Migration
  def change
    create_table :event_recurrences do |t|
      t.string :bill_id
      t.date :start_date
      t.date :end_date
      t.string :every

      t.timestamps
    end
  end
end
