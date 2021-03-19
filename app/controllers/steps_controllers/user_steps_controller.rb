module StepsControllers
  class UserStepsController < ApplicationController
    include Wicked::Wizard

    steps *User.form_steps.keys

    def show
      @user = User.uncompleted.find(params[:user_id])
      render_wizard
    end

    def update
      @user = User.uncompleted.find(params[:user_id])
      @user.update(user_params(step))
      render_wizard @user
    end

    private

    def user_params(step)  
      params.require(:user).permit(User.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      @user.update! completed: true
      user_path(@user)
    end
  end
end
