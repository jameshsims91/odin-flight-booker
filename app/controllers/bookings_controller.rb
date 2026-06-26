class BookingsController < ApplicationController
  def new
    flight_id = params[:flight_id] || (params[:booking] && params[:booking][:flight_id])
    @flight = Flight.find(flight_id)
    @booking = Booking.new(flight: @flight)

    @num_tickets = params[:num_tickets] || (params[:booking] && params[:booking][:num_tickets])
    @num_tickets = @num_tickets.present? ? @num_tickets.to_i : 1

    @num_tickets.times { @booking.passengers.build }
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.save
      redirect_to root_path, notice: "Flight successfully booked!"
    else
      @flight = Flight.find(booking_params[:flight_id])
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @flight = @booking.flight
  end

  private

  def booking_params
    params.expect(booking: [ :flight_id, passengers_attributes: [ :id, :name, :email ] ])
  end
end
