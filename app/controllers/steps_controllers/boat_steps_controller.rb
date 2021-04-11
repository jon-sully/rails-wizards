module StepsControllers
  class BoatStepsController < ApplicationController
    include Wicked::Wizard

    steps *Boat.form_steps.keys

    def show
      # Boat record id persisted in cache via session id
      @boat = Boat.find Rails.cache.read(session.id)
      render_wizard
    end

    def update
      @boat = Boat.find Rails.cache.read(session.id)
      # Use #assign_attributes since render_wizard runs a #save for us
      @boat.assign_attributes boat_params
      render_wizard @boat
    end

    private

    def boat_params
      params.require(:boat).permit(Boat.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      # Clear out the session cache so the user can create another object
      Rails.cache.delete session.id
      boat_path(@boat)
    end
  end
end
