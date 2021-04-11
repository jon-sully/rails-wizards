class CreateDesks < ActiveRecord::Migration[6.1]
  def change
    create_table :desks do |t|
      t.string :material_preference
      t.string :color
      t.string :sit_height
      t.string :stand_height
      t.integer :length
      t.integer :width

      t.timestamps
    end
  end
end
