# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :image

  belongs_to :user
  has_many :comment
end
