# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# Categories for post
class Category < ApplicationRecord
  has_many :posts
  validates :name, uniqueness: true
end
