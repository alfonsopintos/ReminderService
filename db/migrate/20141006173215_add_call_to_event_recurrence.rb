class AddCallToEventRecurrence < ActiveRecord::Migration
  def change
    add_column :event_recurrences, :call_reminder, :text
  end
end
