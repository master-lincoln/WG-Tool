class CreateDuties < ActiveRecord::Migration
  def change
    create_table :duties do |t|
      t.integer :invoice_id
      t.integer :user_id

      t.timestamps
    end
  end
end
