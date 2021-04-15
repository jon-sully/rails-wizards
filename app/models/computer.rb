# Generated from
# rails g scaffold Computer manufacturer year_started model processor graphics_chip exterior_color weight form_completed:boolean

class Computer < ApplicationRecord
  default_scope { where form_completed: true }
  scope :form_not_completed_only, -> { unscope(where: :form_completed).where(form_completed: false) }

  enum form_steps: {
    maker_details: [:manufacturer, :year_started],
    internals: [:model, :processor, :graphics_chip],
    externals: [:exterior_color, :weight]
  }
  attr_accessor :form_step

  with_options if: -> { required_for_step?(:maker_details) } do
    validates :manufacturer, presence: true
    validates :year_started, presence: true, numericality: { greater_than: 1985 }
  end

  with_options if: -> { required_for_step?(:internals) } do
    validates :model, presence: true
    validates :processor, presence: true
    validates :graphics_chip, presence: true
  end

  with_options if: -> { required_for_step?(:externals) } do
    validates :exterior_color, presence: true
    # Weight preference optional
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
