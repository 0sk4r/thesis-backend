# frozen_string_literal: true

module Api
  class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def index
      render json: { "test": 'testowa' }
    end

    def create
      post = Post.new(post_params)

      if post.save
        render json: { "message": 'Post successfully created', "post": post }
      else
        render status: 422, json: { "errors": post.errors.full_messages.join('. ') }
      end
    end

    private

    def post_params
      params.permit(:content, :title).merge(user_id: current_user.id)
    end
  end
end
