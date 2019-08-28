# frozen_string_literal: true

# Post Serializer
class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :image, :likes, :dislikes, :comment_count

  belongs_to :user
  belongs_to :category
  has_many :comment

  # Add additional fields
  # Count likes
  def likes
    object.like.where(like_type: 0).count
  end

  # Count dislikes
  def dislikes
    object.like.where(like_type: 1).count
  end

  # Count comments
  def comment_count
    object.comment.count
  end
end
