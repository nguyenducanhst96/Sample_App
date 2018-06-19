Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  get "/signup", to: "users#new"
  get "/contact", to: "static_page#contact"
  get "/help", to: "static_page#help"
  get "/about", to: "static_page#about"
  root "static_page#home"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
end
