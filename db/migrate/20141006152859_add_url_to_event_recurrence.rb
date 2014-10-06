class AddUrlToEventRecurrence < ActiveRecord::Migration
  def change
    add_column :event_recurrences, :Url, :text
  end
end
