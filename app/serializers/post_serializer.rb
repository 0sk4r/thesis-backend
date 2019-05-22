# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :image, :likes, :dislikes, :comment_count

  belongs_to :user
  has_many :comment

  def likes
    object.like.where(like_type: 0).count
  end

  def dislikes
    object.like.where(like_type: 1).count
  end

  def comment_count
    object.comment.count
  end
end
