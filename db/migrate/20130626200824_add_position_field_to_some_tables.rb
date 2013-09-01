class AddPositionFieldToSomeTables < ActiveRecord::Migration
  def change
    add_column :articles, :position, :integer
    add_column :categories, :position, :integer
    add_column :photos, :position, :integer
    add_column :products, :position, :integer
  end
end
