json.extract! boat, :id, :name, :location_docked, :length, :width, :displacement, :maximum_speed, :engine_count, :color, :primary_use, :created_at, :updated_at
json.url boat_url(boat, format: :json)
