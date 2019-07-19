# frozen_string_literal: true

module Api
  class NotificationsController < ApplicationController
    before_action :authenticate_user!, only: %i[index destroys]

    def index
      # @notifications = Notification.where(user_id: current_user.id)
      @notifications = current_user.notifications
      render json: @notifications, include: 'action.*.*'
    end

    def destroy
      @notification = current_user.notifications.find(params[:id])
      @notification.destroy
      render json: current_user.notifications, include: 'action.*.*'
    end

    def destroy_all
      @notifications = current_user.notifications
      @notifications.destroy_all
      render json: current_user.notifications, include: 'action.*.*'
    end
  end
end
