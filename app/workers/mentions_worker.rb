# frozen_string_literal: true

class MentionsWorker
  include Sidekiq::Worker

  def perform(comment_id, content)
    mentions = content.scan(/\s@([\w]+)/)
    mentions.each do |mentioned_user|
      user = User.find_by(nickname: mentioned_user)
      Mention.create!(comment_id: comment_id, user_id: user.id) unless user.nil?
    end
  end
end
