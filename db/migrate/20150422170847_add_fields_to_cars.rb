class AddFieldsToCars < ActiveRecord::Migration
  def change
    add_column :cars, :price, :integer
    add_column :cars, :stock, :integer
  end
end
