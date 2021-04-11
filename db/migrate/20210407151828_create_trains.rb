class CreateTrains < ActiveRecord::Migration[6.1]
  def change
    create_table :trains do |t|
      t.integer :length
      t.integer :width
      t.integer :height
      t.integer :maximum_speed
      t.integer :wheel_count
      t.string :color
      t.string :brand_name

      t.timestamps
    end
  end
end
