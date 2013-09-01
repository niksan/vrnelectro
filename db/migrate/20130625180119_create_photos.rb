class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :product_id
      t.string :image
      t.string :ancestry

      t.timestamps
    end
    add_index :photos, :product_id
  end
end
