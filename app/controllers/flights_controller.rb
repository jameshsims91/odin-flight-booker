class FlightsController < ApplicationController
  # GET /flights or /flights.json
  def index
    @airports = Airport.all.order(:code)

    @flight_dates = Flight.order(:start_datetime)
                    .pluck(:start_datetime)
                    .map(&:to_date)
                    .uniq

    @flights = Flight.all

    if params[:departure_code].present?
      @flights = @flights.joins(:departure_airport)
                            .where(airports: { code: params[:departure_code] })
    end

    if params[:arrival_id].present?
      @flights = @flights.joins(:arrival_airport)
                            .where(airports: { code: params[:arrival_code] })
    end

    if params[:date].present?
      target_date = Date.parse(params[:date])
      @flights = @flights.where(start_datetime: target_date.all_day)
    end

    @num_tickets = params[:num_tickets]
  end
end
# # GET /flights/1 or /flights/1.json
# def show
# end

# # GET /flights/new
# def new
#   @flight = Flight.new
# end

# # GET /flights/1/edit
# def edit
# end

# # POST /flights or /flights.json
# def create
#   @flight = Flight.new(flight_params)

#   respond_to do |format|
#     if @flight.save
#       format.html { redirect_to @flight, notice: "Flight was successfully created." }
#       format.json { render :show, status: :created, location: @flight }
#     else
#       format.html { render :new, status: :unprocessable_content }
#       format.json { render json: @flight.errors, status: :unprocessable_content }
#     end
#   end
# end

# # PATCH/PUT /flights/1 or /flights/1.json
# def update
#   respond_to do |format|
#     if @flight.update(flight_params)
#       format.html { redirect_to @flight, notice: "Flight was successfully updated.", status: :see_other }
#       format.json { render :show, status: :ok, location: @flight }
#     else
#       format.html { render :edit, status: :unprocessable_content }
#       format.json { render json: @flight.errors, status: :unprocessable_content }
#     end
#   end
# end

# # DELETE /flights/1 or /flights/1.json
# def destroy
#   @flight.destroy!

#   respond_to do |format|
#     format.html { redirect_to flights_path, notice: "Flight was successfully destroyed.", status: :see_other }
#     format.json { head :no_content }
#   end
# end

# private
#   # Use callbacks to share common setup or constraints between actions.
#   def set_flight
#     @flight = Flight.find(params.expect(:id))
#   end

#   # Only allow a list of trusted parameters through.
#   def flight_params
#     params.expect(flight: [ :departure_airport_id, :arrival_airport_id, :start_datetime, :duration ])
#   end
