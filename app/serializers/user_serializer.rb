# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :nickname, :image
  has_many :posts
end
