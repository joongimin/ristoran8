class AddDescriptionToMenuCategories < ActiveRecord::Migration
  def change
    add_column :menu_categories, :description, :string
  end
end
