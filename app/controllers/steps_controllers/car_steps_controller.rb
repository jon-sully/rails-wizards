module StepsControllers
  class CarStepsController < ApplicationController
    include Wicked::Wizard

    steps *Car.form_steps.keys

    def show
      @car = Car.find(params[:car_id])
      render_wizard
    end

    def update
      @car = Car.find(params[:car_id])
      # Use #assign_attributes since render_wizard runs a #save for us
      @car.assign_attributes car_params
      if @car.valid?
        render_wizard @car
      else
        render_wizard @car, status: :unprocessable_entity
      end
    end

    private

    def car_params
      params.require(:car).permit(Car.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      car_path(@car)
    end
  end
end
