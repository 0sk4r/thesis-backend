# frozen_string_literal: true

class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user

  has_many :comment, dependent: :destroy
  has_many :like, dependent: :destroy
  
  belongs_to :category

  validates_presence_of :title, :content
end
