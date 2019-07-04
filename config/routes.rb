# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'
  
  namespace :api do
    resources :posts
    resources :comments
    resources :likes

    get '/users/find', to: "users#find"
    resources :notifications
  end
end
