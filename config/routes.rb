# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  namespace :api do
    get '/search(/:key)', to: 'posts#search'
    resources :posts do
      get 'page/:page', action: :index, on: :collection
    end
    resources :posts, only: %i[show create edit update]
    resources :comments, only: %i[create]
    resources :likes, only: [:create]
    get '/users/getInfo', to: 'users#my_info'
    patch '/users/edit', to: 'users#update'
    get '/users/edit', to: 'users#edit'
    get '/users/find', to: 'users#find'
    get '/users/:id/page/:page', to: 'users#show'
    resources :users, only: %i[edit update]

    get '/users/:id/posts', to: 'users#user_posts'
    delete '/notifications/delete_all', to: 'notifications#destroy_all'
    resources :notifications, only: %i[index destroy]
    resources :categories, only: %i[index show]

    post '/follows/', to: 'follows#create'
  end
end
