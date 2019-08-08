# frozen_string_literal: true

class NotificationsService
  def initialize(action_id, action_type, user_id)
    @action_id = action_id
    @action_type = action_type
    @user_id = user_id
  end

  def call
    Notification.create(user_id: @user_id, action_id: @action_id, action_type: @action_type)
  end
end
