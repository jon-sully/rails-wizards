module StepsControllers
  class ComputerStepsController < ApplicationController
    include Wicked::Wizard

    steps *Computer.form_steps.keys

    def show
      @computer = Computer.form_not_completed_only.find(params[:computer_id])
      render_wizard
    end

    def update
      @computer = Computer.form_not_completed_only.find(params[:computer_id])
      # Use #assign_attributes since render_wizard runs a #save for us
      @computer.assign_attributes computer_params
      render_wizard @computer
    end

    private

    def computer_params
      params.require(:computer).permit(Computer.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      @computer.update! form_completed: true
      computer_path(@computer)
    end
  end
end
