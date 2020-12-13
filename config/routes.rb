Rails.application.routes.draw do
  root 'shops#index'
  get "/shops/:user_id", to: 'shops#items'
  get "/shops/:user_id/:id", to: 'shops#show'
  resources :items
  #root 'home#index'
  devise_for :users, :controllers => {registrations: 'registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
