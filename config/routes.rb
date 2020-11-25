Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to: 'users#page'
  resources :users
  resources :addresses
  resources :companies
  resources :cities
  resources :states
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  devise_scope :user do
    get '/get_city', to: 'users/registrations#get_city'
    # get 'check_active', to: "devise/sessions#check_active"
  end

end
