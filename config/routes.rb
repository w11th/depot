Rails.application.routes.draw do
  resources :carts
  root 'stores#index', as: 'stores_index'

  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
