Rails.application.routes.draw do
  get 'admins' => 'admins#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users

  resources :products do
    get :who_bought, on: :member
  end

  scope '(:locale)' do
    resources :orders
    resources :line_items do
      member do
        post 'increase', 'decrease'
      end
    end
    resources :carts
    root 'stores#index', as: 'stores_index', via: :all
  end

  # namespace 'api', path: '/', constraints: { subdomain: 'api' } do
  #   resources :humans
  # end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
