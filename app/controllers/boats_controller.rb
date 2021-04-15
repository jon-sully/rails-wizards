class BoatsController < ApplicationController
  before_action :set_boat, only: %i[ show edit update destroy ]

  # GET /boats or /boats.json
  def index
    @boats = Boat.all
  end

  # GET /boats/1 or /boats/1.json
  def show
  end

  # GET /boats/new
  def new
    # If they already started one, use that.
    unless boat_id = Rails.cache.read("#{session.id}_boat_form")          # Only non-vanilla-Rails code here
      @boat = Boat.new
      @boat.save! validate: false                                         # Only non-vanilla-Rails code here
      Rails.cache.write("#{session.id}_boat_form", @boat.id)              # Only non-vanilla-Rails code here
    end
    redirect_to build_boat_path(Boat.form_steps.keys.first)               # Only non-vanilla-Rails code here
  end

  # GET /boats/1/edit
  def edit
  end

  # POST /boats or /boats.json
  def create
    @boat = Boat.new(boat_params)

    respond_to do |format|
      if @boat.save
        format.html { redirect_to @boat, notice: "Boat was successfully created." }
        format.json { render :show, status: :created, location: @boat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @boat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boats/1 or /boats/1.json
  def update
    respond_to do |format|
      if @boat.update(boat_params)
        format.html { redirect_to @boat, notice: "Boat was successfully updated." }
        format.json { render :show, status: :ok, location: @boat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @boat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boats/1 or /boats/1.json
  def destroy
    @boat.destroy
    respond_to do |format|
      format.html { redirect_to boats_url, notice: "Boat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boat
      @boat = Boat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def boat_params
      params.require(:boat).permit(:name, :location_docked, :length, :width, :displacement, :maximum_speed, :engine_count, :color, :primary_use)
    end
end
