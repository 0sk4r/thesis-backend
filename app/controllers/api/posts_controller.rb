# frozen_string_literal: true

module Api
    class PostsController < ApplicationController
        before_action :authenticate_user!, only: [:create]

      def index
        render json: { "test": 'testowa' }
      end
  
    def create
        post = Post.new(post_params)

        respond = if post.save
            {"message": "Succes"}
          else
            {"error": post.errors.full_messages.join('. ')}
          end

        render json: respond
    end

    private
    def post_params
        params.require(:post).permit(:content, :title, :user_id)
    end
  end
end