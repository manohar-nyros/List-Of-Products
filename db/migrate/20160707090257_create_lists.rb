class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.string :description
      t.string :text
      t.float :price
      t.integer :quantity
      t.float :vat
      t.float :total
      t.string :product_id

      t.timestamps null: false
    end
  end
end
