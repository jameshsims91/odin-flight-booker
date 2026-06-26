json.extract! flight, :id, :departure_airport_id, :arrival_airport_id, :start_datetime, :duration, :created_at, :updated_at
json.url flight_url(flight, format: :json)
