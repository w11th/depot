Rails.application.routes.draw do
  root 'stores#index', as: 'stores_index'

  resources :products
  resources :carts
  resources :line_items do
    member do
      post 'increase', 'decrease'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
