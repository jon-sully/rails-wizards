class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.string :transmission_type
      t.integer :seat_count
      t.integer :ride_height
      t.string :preferred_engine_type
      t.string :exterior_color
      t.string :interior_material

      t.timestamps
    end
  end
end
