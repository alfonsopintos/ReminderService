class RemoveUserFromApiKey < ActiveRecord::Migration
  def change
    remove_column :api_keys, :user, :string
  end
end
