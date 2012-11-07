class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name, :limit => 50
      t.string :description, :limit => 300

      t.timestamps
    end
  end
end
