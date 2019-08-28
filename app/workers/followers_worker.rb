# frozen_string_literal: true

# Notificate follower user after post create in background
class FollowersWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find(post_id)
    # Get all followers for post creater
    follows = post.user.follows

    # Create notification for each follower
    follows.each do |follow|
      NotificationsService.new(action_id: post_id, action_type: post.class, user_id: follow.follower_id).call
    end
  end
end
