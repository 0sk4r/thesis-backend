# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    before_action :authenticate_user!, only: %i[update edit my_info]

    # API for managing users data

    # Authentication headers:
    # "access-token": "wwwww",
    # "token-type":   "Bearer",
    # "client":       "xxxxx",
    # "expiry":       "yyyyy",
    # "uid":          "zzzzz"

    # GET /api/users/find Find users which nickname contain key
    # params: key searched nickname
    # Return list of nickname containing key
    def find
      provider = UserProvider.new(params[:key])
      render json: provider.results
    end

    # GET /api/users/:id Get info about user with :id
    # params: :id user id
    # response with:
    # {
    #   "id": Integer, #User ID
    #   "name": String, #User name
    #   "nickname": String, #User nickname
    #   "image": {
    #       "url": String #URL to avatar
    #   }
    # }
    def show
      id = params[:id]
      @user = User.find(id)
      render json: @user
    end

    # GET /api/users/:id/posts Get selected user posts
    # params: :id User ID
    def user_posts
      @user = User.find(params[:id])
      render json: @user.posts
    end

    # GET /api/users/:id/edit Get data to edit for user with :id
    # params: :id User ID
    # Require authentication headers
    # Response with:
    # {
    #   "id": Integer, #User ID
    #   "name": String, #User name
    #   "nickname": String, #User nickname
    #   "image": {
    #       "url": String #URL to avatar
    #   }
    # }
    def edit
      @user = User.find(current_user.id)

      render json: @user
    end

    # PUT /api/users/:id Update user data
    # params: :id User ID
    # Response with updated user record
    # {
    #   "id": Integer, #User ID
    #   "name": String, #User name
    #   "nickname": String, #User nickname
    #   "image": {
    #       "url": String #URL to avatar
    #   }
    # }
    def update
      @user = User.find(current_user.id)

      @user.update(user_params)

      if @user.save
        render json: { "message": 'User successfully updated', "user": @user }
      else
        render status: 422, json: { "errors": @user.errors.full_messages.join('. ') }
      end
    end

    # GET /api/users/getInfo Get info about currently logged user
    # Require authentication headers
    # Response with:
    # {
    #   "id": Integer, #User ID
    #   "name": String, #User name
    #   "nickname": String, #User nickname
    #   "image": {
    #       "url": String #URL to avatar
    #   }
    # }
    def my_info
      @user = User.find(current_user.id)
      render json: @user
    end

    private

    def user_params
      params.permit(:name, :nickname, :image)
    end
  end
end
