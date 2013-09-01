class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :category_id
      t.string :lot
      t.string :name
      t.text :description
      t.decimal :price, precision: 7, scale: 2, default: 0.00
      t.string :ancestry
      t.string :slug
      t.text :related_products
      t.boolean :disabled, default: false

      t.timestamps
    end
    add_index :products, :ancestry
    add_index :products, :slug
  end
end
