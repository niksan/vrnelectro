class ChangePriceFieldSizeInProducts < ActiveRecord::Migration
  def up
    change_column :products, :price, :float, { precision: 11, scale: 2 }
  end

  def down
    change_column :products, :price, :float, { precision: 7, scale: 2 }
  end
end
