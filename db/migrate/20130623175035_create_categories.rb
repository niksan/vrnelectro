class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.string :ancestry

      t.timestamps
    end
    add_index :categories, :ancestry
    add_index :categories, :slug
  end
end
