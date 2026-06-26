class BookingsController < ApplicationController
  def new
    @flight = Flight.find(params[:flight_id])
    @booking = Booking.new(flight: @flight)

    @num_tickets = params[:num_tickets].to_i
    @num_tickets.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to root_path, notice: "Flight successfully booked!"
    else
      @flight = FLight.find(booking_params[:flight_id])
      render :new, status: :unprocessable_entity
    end
  end

  private

  def booking_params
    params.expect(booking: [ :flight_id, passengers_attributes: [ :id, :name, :email ] ])
  end
end
