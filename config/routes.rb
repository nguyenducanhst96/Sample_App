Rails.application.routes.draw do
  get "/signup", to: "users#new"
  get "/contact", to: "static_page#contact"
  get "/help", to: "static_page#help"
  get "/about", to: "static_page#about"
  root "static_page#home"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
