Rails.application.routes.draw do
  resources :post_tags
  resources :categories
  resources :posts
  resources :users

  root 'application#home', as: 'home'
  get '/login', to: "sessions#new", as: 'login'
  post '/login', to: "sessions#create"
  delete '/sessions', to: "sessions#destroy", as: 'logout'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
