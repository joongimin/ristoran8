class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.references :menu_category
      t.timestamps
    end
    add_index :menu_items, :menu_category_id
  end
end
