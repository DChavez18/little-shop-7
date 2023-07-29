Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :merchants do
    resources :dashboards
    resources :items
    resources :invoices
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants
    resources :invoices, except: [:new, :destroy]
  end

end
