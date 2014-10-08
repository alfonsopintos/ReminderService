class AddClientToApiKey < ActiveRecord::Migration
  def change
    add_reference :api_keys, :client, index: true
  end
end
