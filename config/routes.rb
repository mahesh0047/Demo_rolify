# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :projects
  resources :languages
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth' }
  resources :users do
    get :page
  end
  resources :addresses
  resources :companies
  resources :cities
  resources :states
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_scope :user do
    get '/getcity', to: 'users/registrations#getcity'
    # get 'check_active', to: "devise/sessions#check_active"
  end

  namespace :admin do
    resources :users
  end

  namespace :team_leader do
    resources :users
  end

  namespace :devloper do
    resources :users
  end

  namespace :trainee do
    resources :users, only: %i[show index]
  end
end
