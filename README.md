# rails-wizards

This repository accompanies this blog post: ["Multi-page Forms ('Wizards') In Rails + Hotwire / Turbo Frames"](https://jonsully.net/blog/multi-step-forms-in-rails-with-hotwire-turbo-frames/)

The important files to look at (optional tweaks included):

**Model:**

[/app/models/house.rb](/app/models/house.rb)

**Top-level Controller:**

[/app/controllers/houses_controller.rb](/app/controllers/houses_controller.rb)

**Steps Controller:**

[/app/controllers/steps_controllers/house_steps_controller.rb](/app/controllers/steps_controllers/house_steps_controller.rb)

**Step Views:**

[/app/views/steps_controllers/house_steps/address_info.html.erb](/app/views/steps_controllers/house_steps/address_info.html.erb)

[/app/views/steps_controllers/house_steps/house_info.html.erb](/app/views/steps_controllers/house_steps/house_info.html.erb)

[/app/views/steps_controllers/house_steps/house_stats.html.erb](/app/views/steps_controllers/house_steps/house_stats.html.erb)

**Routes:**

[/config/routes.rb](/config/routes.rb)

## TODOs

- Let me make this clear from the start. As with most things in Rails given its flexibility and versatility, there is no plain prescription for multi-step forms / Wizards in Rails. You need to read through and choose the one that you feel best fits your particular needs. 
- Make sure every wizard implements the forward and backward buttons/links
- Make sure every top level controller index page has a summary on top
- Extras:
  - Default scope for the DB-persisted records
    - Can be okay with a default scope and a second scope to be the opposite side of the default scope but can definitely be tricky depending on how much access you want to the non-completed side and understanding that when you create a new record it will default to the shown-side of the scope (completed: true) — not necessarily a bad thing since you likely want users created outside of the wizard to be auto-completed, but something to be aware of.
  - current_step helper if necessary
- Database persisted with ID in session (and default scope) and cache-persisted with session-key would both actually work fairly well for Agent Pronto's needs: neither will show IDs in the URL, neither will muddy up the application data when just calling out for MyModel.all, and neither will have any issues running per-step validations. The only reason I'm choosing to go with the cache route instead of the database route is persistence. Inherently with our form being totally public and our platform having no 'user login' anyway, there's nothing to tie a partially-completed wizard object back to. Instead it would be an incomplete record in the database that may ultimately be orphaned when that user's session ID churns anyway. That's a distinctly different use-case from a wizard where the users _are_ authenticated and you _do_ have a specific User to tie the partially-completed submission back to forever. Since the database route has the potential to create lots of DB records that are orphaned by a mechanism beyond their control, I'm going with the cache-based approach for us. There's just no need to create actual persisting database records (en masse) for a public-facing form that receives millions of hits.
- Pt. 8 — Tangible Examples (repo overview)
- "Save and back vs. just "previous step"?
- Technically we don't need to use method: :patch on the cache-persisted side of things, but it does feel a little more RESTful I guess.
- Pt. 9 — Thanks and credits to inspirations?
- Cache-persisted but with the cache key in the URL?


```ruby
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
```


Defined in the model:

```ruby
  # NOTE: just trying this out and seeing how it might be helpful?
  # Get current step by determining the first step where validations fail
  def current_step
    @current_step ||= self.class.form_steps.keys.map(&:to_sym).find do |step|
      self.form_step = step
      step unless valid?
    end
  end
```

```ruby
# STEPS FORWARD

# 1) Make the last step a _top targeting step and use status: :unprocessable_entity on #update response
#    - In the case that there are NO validation errors, this works great and redirects the user properly
#      as a full Turbo Drive movement rather than a Turbo Frame render
#    - In the case that there ARE validation errors, the entire page gets re-rendered to the last step's
#      view. This doesn't follow the each-step-is-just-a-frame idea.
# 2) Make the last step NOT _top targeting (normal frame) and ?
#    - In the case that there are NO validation errors, no frame is found in the response so JS error
#    - In the case that there ARE validation errors, we see the frame rendered in place with the errors
#      in the 'normal' way and all is well.
# 
# It appears there's no way to respond with a navigation directive to a _frame_ request and have it
# re-render the whole page. It _only_ cares about the frame. 😕
#
# This PR will augment the _top (#1) workflow to not re-render the whole page on validation failures so
# safe to use #1 for this guide
# https://github.com/hotwired/turbo/pull/210

# Turbo Frame navigations skip rendering the layout around the view when the `Turbo-Frame` header is in
# place; this header _is_ set for idempotent navigations (links/anchors/GETs — even form submissions if
# they're using GET etc.) but Turbo(client) doesn't add `Turbo-Frame` header for potentially-destructive
# verbs (PATCH, PUT) 🤔 doesn't make much sense given that the frame isn't targeting _top.
# 
# This goes along with the Rails ethos that the only way a user should be able to commit destructive
# actions is through form submits (one way or another) — likely for safety/security reasons.
# 
# Using #edit vs. #show
# Realistically this _could_ be edit instead of show, but then you'd get URLs like /houses/37/address_info/edit
# Just need to change the top-level controller to redirect to edit_house_step_path(@house, House.form_steps.keys.first)
```

```ruby
  # NOTE: This default scope exists as a mechanism to ensure that this model is
  # never called _without_ a scope applied
  default_scope { where(no_scope_applied_to_model: "That's bad") }
  scope :with_favorite_pizza, -> { unscope(where: :no_scope_applied_to_model).where.not(favorite_pizza: nil) }
```
^ This does make the 'create' side of things a little wonky since you'll need to make an
object within a scope every time. So `User.


Aside from the risk of runaway database record creation, this baseline approach can muddy up your
development experience since any given MyModel.last could actually be in incomplete model. We attempt
to resolve this issue in later examples with default_scopes and etc, but we cannot escape the reality
that each time the wizard is executed, a new database record is created; a new primary key ID is used.
That side effect and this approach should be carefully considered before use in a very-high-traffic
environemnt, especially those that have no User object / authentication to correlate records to.

On an opinion level, this feels like the direction Rails apps should go in. Turbo Frames make the UI
workflow very quick and smooth while keeping all validations server-side and not littering the
database with partially-completed records.



For the routes like the books routes (`ruby>resources :build_book, only: []`) can I just use a scope
or namespace? Pointless to declare resources but with no actions 🤔

Re: strategies for avoiding nosy neighbors with public-facing forms when using DB-persistence and ID/Key-in-URL: (_although you could add a random_ `public_facing_key` _to your database records and achieve the same 'random character routing key' effect that Cache-Persistence has with ID/Key-in-URL above_)
