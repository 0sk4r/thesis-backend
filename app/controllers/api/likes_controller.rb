# frozen_string_literal: true

module Api
  class LikesController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def create
      # like = Like.new(like_params)
      @post = Post.find(params[:post_id])
      like = @post.like.find_or_create_by(user_id: current_user.id)

      if like.like_type == params[:like_type]
        like.destroy
        render json: @post
      else
        like.like_type = params[:like_type]

        if like.save
          render json: @post
        else
          render status: 422, json: { "errors": like.errors.full_messages.join('. ') }
        end

      end
    end

    private

    def like_params
      params.permit(:post_id, :like_type).merge(user_id: current_user.id)
    end
  end
end
