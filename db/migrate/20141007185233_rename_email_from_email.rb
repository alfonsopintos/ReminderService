class RenameEmailFromEmail < ActiveRecord::Migration
  def change
    rename_column :emails, :email, :email_address
  end
end
