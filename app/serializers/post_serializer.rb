class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :image

  belongs_to :user
end
