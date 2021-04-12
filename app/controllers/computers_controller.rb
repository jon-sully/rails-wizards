class ComputersController < ApplicationController
  before_action :set_computer, only: %i[ show edit update destroy ]

  # GET /computers or /computers.json
  def index
    @computers = Computer.all
  end

  # GET /computers/1 or /computers/1.json
  def show
  end

  # GET /computers/new
  def new
    @computer = Computer.new form_completed: false                                  # Only non-vanilla-Rails code here
    @computer.save! validate: false                                                 # Only non-vanilla-Rails code here
    redirect_to computer_step_path(@computer, Computer.form_steps.keys.first)       # Only non-vanilla-Rails code here
  end

  # GET /computers/1/edit
  def edit
  end

  # POST /computers or /computers.json
  def create
    @computer = Computer.new(computer_params)

    respond_to do |format|
      if @computer.save
        format.html { redirect_to @computer, notice: "Computer was successfully created." }
        format.json { render :show, status: :created, location: @computer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @computer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /computers/1 or /computers/1.json
  def update
    respond_to do |format|
      if @computer.update(computer_params)
        format.html { redirect_to @computer, notice: "Computer was successfully updated." }
        format.json { render :show, status: :ok, location: @computer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @computer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /computers/1 or /computers/1.json
  def destroy
    @computer.destroy
    respond_to do |format|
      format.html { redirect_to computers_url, notice: "Computer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_computer
      @computer = Computer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def computer_params
      params.require(:computer).permit(:manufacturer, :year_started, :model, :processor, :graphics_chip, :exterior_color, :weight)
    end
end
