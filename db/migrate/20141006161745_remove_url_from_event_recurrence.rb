class RemoveUrlFromEventRecurrence < ActiveRecord::Migration
  def change
    remove_column :event_recurrences, :Url, :text
  end
end
