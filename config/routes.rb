Rails.application.routes.draw do
  resources :comments
  resources :user_sessions
  resources :users
  get "items", to: "items#top"
  root "items#top"
  get "login", to: 'user_sessions#new'
  post "login", to: 'user_sessions#create'
  delete "logout", to: 'user_sessions#destroy'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :items do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :users, only: [:new, :create, :index]
end
