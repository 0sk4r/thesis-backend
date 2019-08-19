# frozen_string_literal: true

module Api
  class NotificationsController < ApplicationController
    before_action :authenticate_user!, only: %i[index destroys]

    # API for managing notifications

    # Authentication headers:
    # "access-token": "wwwww",
    # "token-type":   "Bearer",
    # "client":       "xxxxx",
    # "expiry":       "yyyyy",
    # "uid":          "zzzzz"

    # GET  /api/notifications Get notifications for logged user
    # Require authentication headers
    # Response with array of notifications:
    # [{ id: Integer, #Notification id
    #   action_type: String, Type of action that trigger notification
    #   action: Object, object that trigger notification
    #   created_at: Date, Notification creation date
    # },...]
    def index
      @notifications = current_user.notifications
      render json: @notifications, include: 'action.*.*'
    end

    # DELETE /api/notifications/:id Delet notification with :id
    # Require authentication headers. Notification can only delete assocciated user
    # Response with current array of notifications
    def destroy
      @notification = current_user.notifications.find(params[:id])
      @notification.destroy
      render json: current_user.notifications, include: 'action.*.*'
    end

    # DELETE /api/notifications/delete_all Delete all notifications associated with user
    # Require authentication headers
    # Response with current array of notifications
    def destroy_all
      @notifications = current_user.notifications
      @notifications.destroy_all
      render json: current_user.notifications, include: 'action.*.*'
    end
  end
end
