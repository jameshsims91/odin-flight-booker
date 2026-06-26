class AirportsController < ApplicationController
  before_action :set_airport, only: %i[ show edit update destroy ]

  # GET /airports or /airports.json
  def index
    @airports = Airport.all
  end

  # GET /airports/1 or /airports/1.json
  def show
  end

  # GET /airports/new
  def new
    @airport = Airport.new
  end

  # GET /airports/1/edit
  def edit
  end

  # POST /airports or /airports.json
  def create
    @airport = Airport.new(airport_params)

    respond_to do |format|
      if @airport.save
        format.html { redirect_to @airport, notice: "Airport was successfully created." }
        format.json { render :show, status: :created, location: @airport }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @airport.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /airports/1 or /airports/1.json
  def update
    respond_to do |format|
      if @airport.update(airport_params)
        format.html { redirect_to @airport, notice: "Airport was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @airport }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @airport.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /airports/1 or /airports/1.json
  def destroy
    @airport.destroy!

    respond_to do |format|
      format.html { redirect_to airports_path, notice: "Airport was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_airport
      @airport = Airport.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def airport_params
      params.expect(airport: [ :code ])
    end
end
