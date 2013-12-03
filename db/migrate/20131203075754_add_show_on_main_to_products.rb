class AddShowOnMainToProducts < ActiveRecord::Migration
  def change
    add_column :products, :show_on_main, :boolean
    add_index :products, :show_on_main
  end
end
