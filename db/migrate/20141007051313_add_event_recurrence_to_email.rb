class AddEventRecurrenceToEmail < ActiveRecord::Migration
  def change
    add_reference :emails, :event_recurrence, index: true
  end
end
