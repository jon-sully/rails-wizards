module StepsControllers
  class HouseStepsController < ApplicationController
    include Wicked::Wizard

    steps *House.form_steps.keys

    def show
      @house = House.uncompleted.find(params[:house_id])
      render_wizard
    end

    def update
      @house = House.uncompleted.find(params[:house_id])
      @house.update(house_params(step))
      render_wizard @house
    end

    private

    def house_params(step)  
      params.require(:house).permit(House.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      @house.update! completed: true
      house_path(@house)
    end
  end
end
