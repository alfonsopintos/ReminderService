class RemoveAddressFromEventRecurrence < ActiveRecord::Migration
  def change
    remove_column :event_recurrences, :url, :text
  end
end
