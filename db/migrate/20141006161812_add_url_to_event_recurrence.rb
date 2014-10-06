class AddUrlToEventRecurrence < ActiveRecord::Migration
  def change
    add_column :event_recurrences, :url, :text
  end
end
