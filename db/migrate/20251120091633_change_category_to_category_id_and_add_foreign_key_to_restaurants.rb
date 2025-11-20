class ChangeCategoryToCategoryIdAndAddForeignKeyToRestaurants < ActiveRecord::Migration[7.1]
  def change
    remove_column :restaurants, :category, :string
    add_reference :restaurants, :category, foreign_key: true
  end
end
