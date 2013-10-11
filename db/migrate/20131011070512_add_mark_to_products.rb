class AddMarkToProducts < ActiveRecord::Migration
  def change
    add_column :products, :mark, :string
  end
end
