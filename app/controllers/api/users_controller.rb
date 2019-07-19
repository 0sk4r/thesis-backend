# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
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
  end
end
