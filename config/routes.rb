Rails.application.routes.draw do

  # 🚂 Vanilla resource scaffold
  resources :trains

  # 👨‍💻 Database persisted, id-in-URL, no turbo frames
  resources :users do 
    resources :steps, only: [:show, :update], controller: 'steps_controllers/user_steps'
  end

  # 🚤 Database persisted, id-in-session, no turbo frames
  resources :boats
  resources :build_boat, only: [:update, :show], controller: 'steps_controllers/boat_steps'

  # 🚙 Database persisted, id-in-URL, turbo frames
  resources :cars do
    resources :steps, only: [:show, :update], controller: 'steps_controllers/car_steps'
  end

  # 💻 Database persisted, id-in-URL, turbo frames, default scoped
  resources :computers do
    resources :steps, only: [:show, :update], controller: 'steps_controllers/computer_steps'
  end

  # 🧍‍♂️ Cache persisted, session-keyed, no turbo frames
  resources :desks
  resources :build_desk, only: [:update, :show], controller: 'steps_controllers/desk_steps'
  
  # 🏡 Cache persisted, session keyed, turbo frames
  resources :houses
  resources :build_house, only: [:update, :show], controller: 'steps_controllers/house_steps'

  # 📚 Cache persisted, key-in-URL, turbo frames
  resources :books
  resources :build_book, only: [] do
    resources :step, only: [:update, :show], controller: 'steps_controllers/book_steps'
  end

  # /build_book/1241421/basic_info

  root 'application#index'
end
