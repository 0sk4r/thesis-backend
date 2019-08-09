# frozen_string_literal: true

module Api
  class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def create
      comment = Comment.new(comment_params)

      if comment.save
        render json: { "message": 'Comment successfully created', "comment": comment }
      else
        render status: 422, json: { "errors": comment.errors.full_messages.join('. ') }
      end
    end

    private

    def comment_params
      params.permit(:content, :post_id).merge(user_id: current_user.id)
    end
  end
end
