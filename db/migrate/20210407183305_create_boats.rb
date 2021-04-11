class CreateBoats < ActiveRecord::Migration[6.1]
  def change
    create_table :boats do |t|
      t.string :name
      t.string :location_docked
      t.integer :length
      t.integer :width
      t.integer :displacement
      t.integer :maximum_speed
      t.integer :engine_count
      t.string :color
      t.string :primary_use

      t.timestamps
    end
  end
end
