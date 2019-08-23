# frozen_string_literal: true

module Api
  class CommentsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    # API for creating comments

    # Authentication headers:
    # "access-token": "wwwww",
    # "token-type":   "Bearer",
    # "client":       "xxxxx",
    # "expiry":       "yyyyy",
    # "uid":          "zzzzz"

    # POST /api/comments crate comment for post with :post_id
    # params:
    #       :post_id Post ID of associated post
    #       :content  comment content
    # Response with updated post data

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
