class Car < ApplicationRecord
  FORM_TURBO_FRAME_ID = 'car_multi_step_form'

  enum form_steps: {
    functional_parts: [:transmission_type, :seat_count],
    mechanical: [:ride_height, :preferred_engine_type],
    user_choices: [:exterior_color, :interior_material]
  }
  attr_accessor :form_step

  with_options if: -> { required_for_step?(:functional_parts) } do
    validates :transmission_type, presence: true
    validates :seat_count, presence: true
  end

  with_options if: -> { required_for_step?(:mechanical) } do
    validates :ride_height, presence: true, numericality: { greater_than: 2 }
    validates :preferred_engine_type, presence: true
  end

  with_options if: -> { required_for_step?(:user_choices) } do
    # User choices optional
  end

  # Checks current step to enable or disable validations appropriately
  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?
  
    # All fields from previous steps are required
    ordered_keys = self.class.form_steps.keys.map(&:to_sym)
    !!(ordered_keys.index(step) <= ordered_keys.index(form_step))
  end

end
