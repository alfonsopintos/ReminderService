class AddMessageToEmail < ActiveRecord::Migration
  def change
    add_column :emails, :email_reminder, :text
  end
end
