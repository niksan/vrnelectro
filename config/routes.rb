VrnElectro::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  root to: 'main#index'

  resources :categories, only: [:show] do
    resources :products, only: [:show]
  end

  namespace :cart do
    post 'items/:id', to: "items#create", as: 'items'
  end

  get 'cart' => 'cart#index', as: 'cart_index'
  put 'cart' => 'cart#update', as: 'cart'

  resources :orders, only: [:new, :create]

end
