class AddEventRecurrenceToCall < ActiveRecord::Migration
  def change
    add_reference :calls, :event_recurrence, index: true
  end
end
