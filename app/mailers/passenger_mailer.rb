class PassengerMailer < ApplicationMailer
  default from: "notifications@flightbooking.com"

  def booking_confirmation(passenger, booking)
    @passenger = passenger
    @booking = booking
    @flight = booking.flight

    mail(
      to: @passenger.email,
      subject: "Booking Confirmed! Flight FL-#{@flight.id}"
    )
  end
end
