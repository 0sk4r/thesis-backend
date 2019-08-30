# frozen_string_literal: true

class Follow < ApplicationRecord
  validates :follower, uniqueness: { scope: :following,
                                     message: 'You are following this user' }
  belongs_to :follower, class_name: 'User', foreign_key: 'follower_id'
  belongs_to :following, class_name: 'User', foreign_key: 'following_id'

  has_one :notification, as: :action
end
