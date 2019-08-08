# frozen_string_literal: true

module Api
  class PostsController < ApplicationController
    before_action :authenticate_user!, only: %i[create edit]

    def index
      @posts = Post.all.order(created_at: :desc)
      render json: @posts, include: %w[user category]
    end

    def show
      @post = Post.find(params[:id])

      render json: @post, include: ['user', 'category', 'comment.user']
    end

    def create
      post = Post.new(post_params)

      if post.save
        render json: { "message": 'Post successfully created', "post": post }
      else
        render status: 422, json: { "errors": post.errors.full_messages.join('. ') }
      end
    end

    def edit
      @post = Post.find(params[:id])

      if @post.user_id != current_user.id
        render status: 401, json: { "errors": 'You are not allowed to do this.' }
      else
        render json: @post, include: ['category']
      end
    end

    def update
      @post = Post.find(params[:id])

      @post.update(post_params)

      if @post.save
        render json: { "message": 'Post successfully updated', "post": @post }
      else
        render status: 422, json: { "errors": @post.errors.full_messages.join('. ') }
      end
    end

    private

    def post_params
      params.permit(:content, :title, :image, :category_id).merge(user_id: current_user.id)
    end
  end
end
