class RenameBillFromEventRecurrence < ActiveRecord::Migration
  def change
    rename_column :event_recurrences, :bill_id, :object_id
  end
end
