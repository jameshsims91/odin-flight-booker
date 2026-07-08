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
    # save! triggers a red crash screen if data is invalid, making debugging easy
    if @booking.save!
      @booking.passengers.each do | passenger |
        PassengerMailer.booking_confirmation(passenger, @booking).deliver_later
      end

      redirect_to @booking, notice: "Booking successfully completed! Confirmation emails have been sent.", status: :see_other
    else
      @flight = Flight.find(params[:booking][:flight_id])
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.includes(:passengers).find(params[:id])
    @flight = @booking.flight
  end

  private

  def booking_params
    params.require(:booking).permit(
      :flight_id,
      passengers_attributes: [ :id, :name, :email, :_destroy ]
    )
  end
end
