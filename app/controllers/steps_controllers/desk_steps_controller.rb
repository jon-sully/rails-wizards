module StepsControllers
  class DeskStepsController < ApplicationController
    include Wicked::Wizard

    steps *Desk.form_steps.keys

    def show
      desk_attrs = Rails.cache.fetch "#{session.id}_desk_form"
      @desk = Desk.new desk_attrs
      render_wizard
    end

    def update
      desk_attrs = Rails.cache.fetch("#{session.id}_desk_form").merge desk_params
      @desk = Desk.new desk_attrs.merge(form_step: step.to_sym)

      if @desk.valid?
        Rails.cache.write "#{session.id}_desk_form", desk_attrs
        redirect_to_next next_step
      else
        render_wizard nil, status: :unprocessable_entity
      end
    end

    private

    def desk_params
      params.require(:desk).permit(Desk.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      desk_attrs = Rails.cache.fetch("#{session.id}_desk_form")
      @desk = Desk.new desk_attrs
      @desk.save!
      Rails.cache.delete "#{session.id}_desk_form"
      desk_path(@desk)
    end
  end
end
