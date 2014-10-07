class RemoveColumnsFromEventRecurrence < ActiveRecord::Migration
  def change
    remove_column :event_recurrences, :cell_phone, :string
    remove_column :event_recurrences, :email, :string
    remove_column :event_recurrences, :contact_method, :string
    remove_column :event_recurrences, :initial, :text
    remove_column :event_recurrences, :text_reminder, :text
    remove_column :event_recurrences, :call_reminder, :text
  end
end
