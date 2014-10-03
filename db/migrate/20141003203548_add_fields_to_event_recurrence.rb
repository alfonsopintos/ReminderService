class AddFieldsToEventRecurrence < ActiveRecord::Migration
  def change
    add_column :event_recurrences, :first_name, :string
    add_column :event_recurrences, :cell_phone, :string
    add_column :event_recurrences, :email, :string
    add_column :event_recurrences, :provider_name, :string
    add_column :event_recurrences, :category_name, :string
    add_column :event_recurrences, :contact_method, :string
  end
end
