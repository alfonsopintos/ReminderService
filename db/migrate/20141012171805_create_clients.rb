class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.integer :text_count
      t.integer :call_count
      t.integer :email_count
    end
  end
end
