class AddAncestryDepthToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :ancestry_depth, :integer
    Category.rebuild_depth_cache!
  end
end
