class AddInfoToEventRecurrence < ActiveRecord::Migration
  def change
    add_column :event_recurrences, :initial, :text
    add_column :event_recurrences, :reminder, :text
  end
end
