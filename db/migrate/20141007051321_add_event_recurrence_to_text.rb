class AddEventRecurrenceToText < ActiveRecord::Migration
  def change
    add_reference :texts, :event_recurrence, index: true
  end
end
