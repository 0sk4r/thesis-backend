# frozen_string_literal: true

class MentionsService
  def initialize(comment_id)
    @comment_id = comment_id
  end

  def call
    @comment = Comment.find(@comment_id)

    mentioned_accounts = @comment.content.scan(/\s@([\w]+)/)

    mentioned_accounts.each do |mentioned_user|
      user = User.find_by(nickname: mentioned_user)
      mention = Mention.create(comment_id: @comment_id, user_id: user.id) unless user.nil?
      NotificationsWorker.perform_async(mention.id, mention.class, mention.user_id)
    end
  end
end
