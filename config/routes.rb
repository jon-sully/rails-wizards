Rails.application.routes.draw do
  namespace :steps_controllers do
    get 'house_steps/show'
    get 'house_steps/update'
  end
  root 'application#index'
  
  resources :houses do
    resources :steps, only: [:show, :update], controller: 'steps_controllers/house_steps'
  end

  resources :users do 
    resources :steps, only: [:show, :update], controller: 'steps_controllers/user_steps'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
