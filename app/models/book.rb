class Book < ApplicationRecord
  FORM_TURBO_FRAME_ID = 'book_multi_step_form'

  enum form_steps: {
    basics: [:title, :author_name],
    organizational: [:year_published, :isbn],
    details: [:primary_topic, :fictionaility]
  }
  attr_accessor :form_step

  with_options if: -> { required_for_step?(:basics) } do
    validates :title, presence: true
    validates :author_name, presence: true
  end

  with_options if: -> { required_for_step?(:organizational) } do
    validates :year_published, presence: true, numericality: { greater_than: 1950 }
    # isbn not required
  end

  with_options if: -> { required_for_step?(:details) } do
    # primary topic not required
    validates :fictionaility, presence: true
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
