# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    before_action :authenticate_user!, only: %i[update edit my_info]

    def find
      provider = UserProvider.new(params[:key])
      render json: provider.results
    end

    def show
      id = params[:id]
      @user = User.find(id)
      render json: @user
    end

    def user_posts
      @user = User.find(params[:id])
      render json: @user.posts
    end

    def edit
      @user = User.find(current_user.id)

      render json: @user
    end

    def update
      @user = User.find(current_user.id)

      @user.update(user_params)

      if @user.save
        render json: { "message": 'User successfully updated', "user": @user }
      else
        render status: 422, json: { "errors": @user.errors.full_messages.join('. ') }
      end
    end

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
