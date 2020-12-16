Rails.application.routes.draw do
  root 'shops#index'
  resources :items
  get "/shops/:user_id", to: 'shops#items'
  get "/shops/:user_id/:id", to: 'shops#show'
  get 'cart_items/add', as: 'add_cart_item'
  get 'cart_items/buy', as: 'buy_cart_item'
  resources :cart_items
  get 'orders/checkout', as: 'checkout_order'
  resources :orders
  #root 'home#index'
  devise_for :users, :controllers => {registrations: 'registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
