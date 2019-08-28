# frozen_string_literal: true

# Find all mentions in comment in background
class MentionsWorker
  include Sidekiq::Worker

  def perform(comment_id)
    MentionsService.new(comment_id).call
  end
end
