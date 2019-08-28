# frozen_string_literal: true

# Category serializer
class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :posts
end
