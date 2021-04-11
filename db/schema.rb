# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_10_172123) do

  create_table "boats", force: :cascade do |t|
    t.string "name"
    t.string "location_docked"
    t.integer "length"
    t.integer "width"
    t.integer "displacement"
    t.integer "maximum_speed"
    t.integer "engine_count"
    t.string "color"
    t.string "primary_use"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cars", force: :cascade do |t|
    t.string "transmission_type"
    t.integer "seat_count"
    t.integer "ride_height"
    t.string "preferred_engine_type"
    t.string "exterior_color"
    t.string "interior_material"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "computers", force: :cascade do |t|
    t.string "manufacturer"
    t.string "year_started"
    t.string "model"
    t.string "processor"
    t.string "graphics_chip"
    t.string "exterior_color"
    t.string "weight"
    t.boolean "form_completed"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "desks", force: :cascade do |t|
    t.string "material_preference"
    t.string "color"
    t.string "sit_height"
    t.string "stand_height"
    t.integer "length"
    t.integer "width"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "houses", force: :cascade do |t|
    t.string "address"
    t.string "exterior_color"
    t.string "interior_color"
    t.string "current_family_last_name"
    t.integer "rooms"
    t.integer "square_feet"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trains", force: :cascade do |t|
    t.integer "length"
    t.integer "width"
    t.integer "height"
    t.integer "maximum_speed"
    t.integer "wheel_count"
    t.string "color"
    t.string "brand_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "middle_name"
    t.string "favorite_pizza"
    t.string "favorite_ice_cream"
    t.string "favorite_sandwich"
    t.string "email"
    t.integer "pet_count"
    t.string "pet_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "completed", default: false, null: false
  end

end
