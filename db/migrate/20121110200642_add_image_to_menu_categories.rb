class AddImageToMenuCategories < ActiveRecord::Migration
  def change
    add_column :menu_categories, :image, :string
  end
end
