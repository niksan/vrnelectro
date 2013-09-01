class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :address
      t.string :email
      t.text :additional
      t.string :state

      t.timestamps
    end
  end
end
