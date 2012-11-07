class CreateMenuCategories < ActiveRecord::Migration
  def change
    create_table :menu_categories do |t|
      t.string :name, :limit => 50
      t.references :restaurant
      t.timestamps
    end
    add_index :menu_categories, :restaurant_id
  end
end
