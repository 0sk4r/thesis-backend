# frozen_string_literal: true

# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  title       :string
#  content     :text
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string
#  category_id :bigint
#

class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :user

  has_many :comment, dependent: :destroy
  has_many :like, dependent: :destroy

  belongs_to :category

  validates_presence_of :title, :content
end
