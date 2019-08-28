# frozen_string_literal: true

# Service for finding mentions in comment
class MentionsService
  def initialize(comment_id)
    @comment_id = comment_id
  end

  def call
    @comment = Comment.find(@comment_id)

    # Find all mentioned @user in post
    mentioned_accounts = @comment.content.scan(/\s@([\w]+)/)

    # For each user create notification
    mentioned_accounts.each do |mentioned_user|
      user = User.find_by(nickname: mentioned_user)
      mention = Mention.create(comment_id: @comment_id, user_id: user.id) unless user.nil?
      NotificationsWorker.perform_async(mention.id, mention.class, mention.user_id)
    end
  end
end
