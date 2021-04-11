class Desk < ApplicationRecord
  enum form_steps: {
    preferences: [:material_preference, :color],
    motor_requirements: [:sit_height, :stand_height],
    desktop_information: [:length, :width]
  }
  attr_accessor :form_step

  with_options if: -> { required_for_step?(:preferences) } do
    validates :material_preference, presence: true
    # color optional
  end

  with_options if: -> { required_for_step?(:motor_requirements) } do
    validates :sit_height, presence: true
    # stand_height optional
  end

  with_options if: -> { required_for_step?(:desktop_information) } do
    validates :length, presence: true, numericality: { greater_than: 31 }
    validates :width, presence: true, numericality: { greater_than: 23 }
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
