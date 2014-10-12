class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :email_address
      t.text :email_reminder
      t.references :event_recurrence, index: true
    end
  end
end
