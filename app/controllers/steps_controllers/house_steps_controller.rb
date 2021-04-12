module StepsControllers
  class HouseStepsController < ApplicationController
    include Wicked::Wizard

    steps *House.form_steps.keys

    def show
      house_attrs = Rails.cache.fetch session.id
      @house = House.new house_attrs
      render_wizard
    end

    def update
      house_attrs = Rails.cache.fetch(session.id).merge house_params
      @house = House.new house_attrs

      if @house.valid?
        Rails.cache.write session.id, house_attrs
        redirect_to_next next_step
      else
        render_wizard nil, status: :unprocessable_entity
      end
    end

    private

    def house_params
      params.require(:house).permit(House.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      house_attrs = Rails.cache.fetch(session.id)
      @house = House.new house_attrs
      @house.save!
      Rails.cache.delete session.id
      house_path(@house)
    end
  end
end
