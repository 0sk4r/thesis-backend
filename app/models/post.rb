# frozen_string_literal: true

class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user

  has_many :comment
  has_many :like

  validates_presence_of :title, :content
end
