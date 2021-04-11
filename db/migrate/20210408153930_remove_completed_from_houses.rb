class RemoveCompletedFromHouses < ActiveRecord::Migration[6.1]
  def change
    remove_column :houses, :completed
  end
end
