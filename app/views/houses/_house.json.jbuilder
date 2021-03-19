json.extract! house, :id, :address, :exterior_color, :interior_color, :current_family_last_name, :rooms, :square_feet, :created_at, :updated_at
json.url house_url(house, format: :json)
