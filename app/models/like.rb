# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id        :bigint           not null, primary key
#  user_id   :bigint
#  post_id   :bigint
#  like_type :integer
#

# Like for posts
class Like < ActiveRecord::Base
  validates :post_id, uniqueness: { scope: :user_id }
  validates_presence_of :like_type
  enum selectable_like_types: %i[like dislike]

  belongs_to :user
  belongs_to :post
end
