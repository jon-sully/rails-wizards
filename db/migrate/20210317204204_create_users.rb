class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :favorite_pizza
      t.string :favorite_ice_cream
      t.string :favorite_sandwich
      t.string :email
      t.integer :pet_count
      t.string :pet_name

      t.timestamps
    end
  end
end
