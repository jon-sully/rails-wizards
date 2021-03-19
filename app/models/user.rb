# Heavily inspired by https://www.joshmcarthur.com/2014/12/23/rails-multistep-forms.html

# This example model shows the multi-step form _without_ Turbo Frames but on a project with
# hotwire installed, you need to add data: { turbo: false } to the form_with as to avoid turbo
# intercepting the requests.

# ✅ TODO: Still want to figure out some kind of scoping for once the model is totally validated.
#   could be a callback for marking some extra field "complete: true" if valid? ✅
# ✅ TODO: any way to restrict a user's ability to reach the multi-step form if the object
#   is already complete? Not sure I want that but would like to know => Add an .update!(completed: true)
#   to the finish_wizard_path. This is way better than the callback before_save to validate against when
#   form_step is nil.
# ✅ TODO: Make another workflow that actually uses Turbo Frames for SPA-like experience

class User < ApplicationRecord
  default_scope -> { where(completed: true) }
  scope :uncompleted, -> { unscope(where: :completed).where(completed: false) }

  # NOTE: Names each step, orders them, and defines which object attributes are allowed /
  #   expected for each step all at once 🤓
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

  # Checks current step to enable or disable validations appropriately
  def required_for_step?(step)
    # All fields are required if no form step is present
    return true if form_step.nil?
  
    # All fields from previous steps are required
    ordered_keys = self.class.form_steps.keys.map(&:to_sym)
    !!(ordered_keys.index(step) <= ordered_keys.index(form_step))
  end
end
