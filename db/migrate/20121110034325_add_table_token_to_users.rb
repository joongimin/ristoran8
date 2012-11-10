class AddTableTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :table_token, :string
  end
end
