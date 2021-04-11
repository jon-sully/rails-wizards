class CreateComputers < ActiveRecord::Migration[6.1]
  def change
    create_table :computers do |t|
      t.string :manufacturer
      t.string :year_started
      t.string :model
      t.string :processor
      t.string :graphics_chip
      t.string :exterior_color
      t.string :weight
      t.boolean :form_completed

      t.timestamps
    end
  end
end
