# Generated from
# rails g scaffold Boat name location_docked length:integer width:integer displacement:integer maximum_speed:integer engine_count:integer color primary_use

class Boat < ApplicationRecord
  enum form_steps: {
    basics: [:name, :location_docked],
    sizes: [:length, :width, :displacement],
    powertrain: [:maximum_speed, :engine_count],
    preferences: [:color, :primary_use]
  }
  attr_accessor :form_step

  with_options if: -> { required_for_step?(:basics) } do
    validates :name, presence: true
    validates :location_docked, presence: true
  end

  with_options if: -> { required_for_step?(:sizes) } do
    validates :length, presence: true, numericality: { greater_than: 5 }
    validates :width, presence: true, numericality: { greater_than: 5 }
    validates :displacement, presence: true, numericality: { greater_than: 100 }
  end

  with_options if: -> { required_for_step?(:powertrain) } do
    validates :maximum_speed, presence: true, numericality: { greater_than: 10 }
    validates :engine_count, presence: true
  end

  with_options if: -> { required_for_step?(:preferences) } do
    validates :color, presence: true
    # Primary use optional
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
