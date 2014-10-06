class RenameReminderFromEventRecurrence < ActiveRecord::Migration
  def change
    rename_column :event_recurrences, :reminder, :text_reminder
  end
end
