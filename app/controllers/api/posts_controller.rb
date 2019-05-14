# frozen_string_literal: true

module Api
  class PostsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def index
      @posts = Post.all
      render json: @posts, include: "user"
    end

    def show
      @post = Post.find(params[:id])
      render json: @post, include: ["user", "comment.user"]
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
      params.permit(:content, :title, :image).merge(user_id: current_user.id)
    end
  end
end
