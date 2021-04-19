module StepsControllers
  class BoatStepsController < ApplicationController
    include Wicked::Wizard

    steps *Boat.form_steps.keys

    def show
      # Boat record id persisted in session
      @boat = Boat.find session[:boat_id]
      render_wizard
    end

    def update
      @boat = Boat.find session[:boat_id]
      # Use #assign_attributes since render_wizard runs a #save for us
      @boat.assign_attributes boat_params
      # This is the work-around discussed in Part 7
      if @boat.valid? 
        render_wizard(@boat) 
      else
        render_wizard(@boat, status: :unprocessable_entity)
      end
    end

    private

    def boat_params
      params.require(:boat).permit(Boat.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      # Clear out the session cache so the user can create another object
      session[:boat_id] = nil
      boat_path(@boat)
    end
  end
end
