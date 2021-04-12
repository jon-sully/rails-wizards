# Generated from
# rails g scaffold User first_name middle_name last_name favorite_pizza favorite_ice_cream favorite_sandwich pet_count:integer pet_name 

class User < ApplicationRecord
  enum form_steps: {
    names: [:first_name, :middle_name, :last_name],
    foods: [:favorite_pizza, :favorite_ice_cream, :favorite_sandwich],
    pets: [:pet_count, :pet_name]
  }
  attr_accessor :form_step

  with_options if: -> { required_for_step?(:names) } do
    validates :first_name, presence: true, length: { minimum: 2, maximum: 20}
    validates :last_name, presence: true, length: { minimum: 2, maximum: 20}
    validates :middle_name, length: { maximum: 20 }
  end

  with_options if: -> { required_for_step?(:foods) } do
    # Foods info is all optional
  end

  with_options if: -> { required_for_step?(:pets) } do
    validates :pet_count, presence: true
    validates :pet_name, presence: true, length: { minimum: 2, maximum: 20}
  end

  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?
  
    # All fields from previous steps are required
    ordered_keys = self.class.form_steps.keys.map(&:to_sym)
    !!(ordered_keys.index(step) <= ordered_keys.index(form_step))
  end
end
