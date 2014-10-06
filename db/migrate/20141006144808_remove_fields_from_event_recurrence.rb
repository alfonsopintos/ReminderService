class RemoveFieldsFromEventRecurrence < ActiveRecord::Migration
  def change
    remove_column :event_recurrences, :category_name, :string
    remove_column :event_recurrences, :provider_name, :string
    remove_column :event_recurrences, :initial, :text
    remove_column :event_recurrences, :text_reminder, :text
    remove_column :event_recurrences, :call_reminder, :text
  end
end
