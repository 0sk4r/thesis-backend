# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text
#  post_id    :bigint
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ApplicationRecord
  after_create :create_mentions

  belongs_to :post
  belongs_to :user

  has_many :mentions, dependent: :destroy
  validates_presence_of :content

  def create_mentions(comment_id: id)
    MentionsWorker.perform_async(comment_id)
  end
end
