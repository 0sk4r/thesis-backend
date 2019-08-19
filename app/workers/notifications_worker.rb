# frozen_string_literal: true

class NotificationsWorker
  include Sidekiq::Worker

  def perform(action_id, action_type, user_id)
    NotificationsService.new(action_id: action_id, action_type: action_type, user_id: user_id).call
  end
end
