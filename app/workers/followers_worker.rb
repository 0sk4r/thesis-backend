# frozen_string_literal: true

class FollowersWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = Post.find(post_id)
    follows = post.user.follows

    follows.each do |follow|
      NotificationsService.new(action_id: post_id, action_type: post.class, user_id: follow.follower_id).call
    end
  end
end
