json.extract! user, :id, :first_name, :last_name, :middle_name, :favorite_pizza, :favorite_ice_cream, :favorite_sandwich, :email, :pet_count, :pet_name, :created_at, :updated_at
json.url user_url(user, format: :json)
