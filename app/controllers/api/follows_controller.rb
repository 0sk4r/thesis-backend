# frozen_string_literal: true

module Api
  class FollowsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def create
      follow = Follow.new(follow_params)

      if follow.save
        render json: { "message": 'Succesfully follow' }
      else
        render status: 422, json: { "errors": follow.errors.full_messages.join('. ') }
      end
    end

    private

    def follow_params
      params.permit(:following_id).merge(follower_id: current_user.id)
    end
  end
end
