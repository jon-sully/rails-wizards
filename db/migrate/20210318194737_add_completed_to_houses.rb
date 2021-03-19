class AddCompletedToHouses < ActiveRecord::Migration[6.1]
  def change
    add_column :houses, :completed, :boolean
  end
end
