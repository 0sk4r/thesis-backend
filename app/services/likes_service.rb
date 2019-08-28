# frozen_string_literal: true

class LikesService
  def initialize(post_id, user_id, like_type)
    @post_id = post_id
    @user_id = user_id
    @like_type = like_type
  end

  # Create of change like type
  def call
    post = Post.find(@post_id)
    # Create or find like
    like = post.like.find_or_create_by(user_id: @user_id)

    # If like exists and like type is the same, destroy it
    if like.like_type == @like_type
      like.destroy
    else
      # if like type is different or there is no existed like. set like type
      like.like_type = @like_type

      return { status: 422, json: { "errors": like.errors.full_messages.join('. ') } } unless like.save
    end

    post
  end
end
