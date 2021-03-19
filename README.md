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
