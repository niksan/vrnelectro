class AddLotIndexToProducts < ActiveRecord::Migration
  def change
    add_index :products, :lot
  end
end
