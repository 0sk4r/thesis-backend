# frozen_string_literal: true

module Api
  class LikesController < ApplicationController
    before_action :authenticate_user!, only: [:create]

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
