class AddFlightNumberToFlights < ActiveRecord::Migration[8.1]
  def change
    add_column :flights, :flight_number, :string
  end
end
