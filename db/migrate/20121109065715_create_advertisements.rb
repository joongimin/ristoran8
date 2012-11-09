class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :name
      t.string :description
      t.references :menu_item

      t.timestamps
    end
  end
end
