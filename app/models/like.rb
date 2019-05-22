# frozen_string_literal: true

class Like < ActiveRecord::Base
  validates :post_id, uniqueness: { scope: :user_id }
  validates_presence_of :like_type
  enum selectable_like_types: %i[like dislike]

  belongs_to :user
  belongs_to :post
end
