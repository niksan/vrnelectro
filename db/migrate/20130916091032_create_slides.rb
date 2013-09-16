class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :name
      t.string :img
      t.string :ancestry
      t.integer :position

      t.timestamps
    end
  end
end
