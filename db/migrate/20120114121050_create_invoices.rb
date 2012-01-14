class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.text :comment
      t.decimal :price
      t.date :date
      t.integer :creator_id

      t.timestamps
    end
  end
end
