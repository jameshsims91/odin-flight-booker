# Preview all emails at http://localhost:3000/rails/mailers/passenger_mailer
class PassengerMailerPreview < ActionMailer::Preview
  def booking_confirmation
    booking = Booking.first || Booking.new(id: 123)
    passenger = Passenger.first || Passenger.new(name: "Jane Doe", email: "jane.doe@example.com")

    if booking.flight.nil?
      departure = Airport.new(code: "NYC")
      arrival = Airport.new(code: "LAX")
      booking.flight = Flight.new(id: 99, departure_airport: departure, arrival_ariport: arrival, start_datetime: Time.current)
    end

    booking.passengers << passenger if booking.passengers.empty?

    PassengerMailer.booking_confirmation(passenger, booking)
  end
end
