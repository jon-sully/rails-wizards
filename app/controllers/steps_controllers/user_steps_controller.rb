module StepsControllers
  class UserStepsController < ApplicationController
    include Wicked::Wizard

    steps *User.form_steps.keys

    def show
      @user = User.find(params[:user_id])
      render_wizard
    end

    def update
      @user = User.find(params[:user_id])
      # Use #assign_attributes since render_wizard runs a #save for us
      @user.assign_attributes user_params
      render_wizard @user
    end

    private

    def user_params
      params.require(:user).permit(User.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      user_path(@user)
    end
  end
end
