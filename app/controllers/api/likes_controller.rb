# frozen_string_literal: true

module Api
  class LikesController < ApplicationController
    before_action :authenticate_user!, only: [:create]
    # API for managing likes

    # Authentication headers:
    # "access-token": "wwwww",
    # "token-type":   "Bearer",
    # "client":       "xxxxx",
    # "expiry":       "yyyyy",
    # "uid":          "zzzzz"

    # POST /api/likes crate like for post with :post_id and :like_type
    # params:
    #       :post_id Post ID of associated post
    #       :like_type  specify like type 0 is positive, 1 is negative
    # Response with updated post data
    def create
      response = LikesService.new(params[:post_id], current_user.id, params[:like_type]).call
      render json: response
    end

    private

    def like_params
      params.permit(:post_id, :like_type).merge(user_id: current_user.id)
    end
  end
end
