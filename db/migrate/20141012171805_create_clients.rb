class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.integer :text_count, default: 0
      t.integer :call_count, default: 0
      t.integer :email_count, default: 0
    end
  end
end
