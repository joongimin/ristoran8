class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :position
      t.references :restaurant

      t.timestamps
    end
  end
end
