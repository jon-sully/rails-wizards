class Train < ApplicationRecord
  enum form_steps: {
    sizing: [:length, :width, :height],
    movement: [:maximum_speed, :wheel_count],
    branding: [:color, :brand_name]
  }
  attr_accessor :form_step

  with_options if: -> { required_for_step?(:sizing) } do
    validates :length, presence: true, numericality: { greater_than: 10, less_than: 50}
    validates :width, presence: true, numericality: { greater_than: 5, less_than: 20}
    validates :height, presence: true, numericality: { greater_than: 5, less_than: 15}
  end

  with_options if: -> { required_for_step?(:movement) } do
    validates :maximum_speed, presence: true, numericality: { greater_than: 10, less_than: 100 }
    validates :wheel_count, presence: true, numericality: { greater_than: 3, less_than: 24 }
  end

  with_options if: -> { required_for_step?(:branding) } do
    validates :color, presence: true
    # Brand name not required
  end

  # Checks current step to enable or disable validations appropriately
  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?
  
    # All fields from previous steps are required
    ordered_keys = self.class.form_steps.keys.map(&:to_sym)
    !!(ordered_keys.index(step) <= ordered_keys.index(form_step))
  end

  # Get current step by determining the first step where validations fail
  def current_step
    self.class.form_steps.keys.map(&:to_sym).each do |step|
      self.form_step = step
      return step unless valid?
    end
  end
end
