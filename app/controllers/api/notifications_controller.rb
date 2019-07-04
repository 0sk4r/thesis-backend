# frozen_string_literal: true

module Api
  class NotificationsController < ApplicationController
    before_action :authenticate_user!, only: [:index]

    def index
      @mentions = Mention.where(user_id: current_user.id)
      render json: @mentions
    end
  end
end
