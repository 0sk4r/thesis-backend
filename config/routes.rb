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
    patch '/users/edit', to: 'users#update'
    get '/users/edit', to: 'users#edit'
    get '/users/find', to: 'users#find'
    resources :users

    get '/users/:id/posts', to: 'users#user_posts'
    delete '/notifications/delete_all', to: 'notifications#destroy_all'
    resources :notifications
    resources :categories, only: [:index]
  end
end
