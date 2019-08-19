# frozen_string_literal: true

class LikesService
  def initialize(post_id, user_id, like_type)
    @post_id = post_id
    @user_id = user_id
    @like_type = like_type
  end

  def call
    post = Post.find(@post_id)
    like = post.like.find_or_create_by(user_id: @user_id)

    if like.like_type == @like_type
      like.destroy
    else
      like.like_type = @like_type

      return { status: 422, json: { "errors": like.errors.full_messages.join('. ') } } unless like.save
    end

    post
  end
end
