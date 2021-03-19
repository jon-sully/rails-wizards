class CreateHouses < ActiveRecord::Migration[6.1]
  def change
    create_table :houses do |t|
      t.string :address
      t.string :exterior_color
      t.string :interior_color
      t.string :current_family_last_name
      t.integer :rooms
      t.integer :square_feet

      t.timestamps
    end
  end
end
