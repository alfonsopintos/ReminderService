class RemoveNameFromEventRecurrence < ActiveRecord::Migration
  def change
    remove_column :event_recurrences, :first_name, :string
  end
end
