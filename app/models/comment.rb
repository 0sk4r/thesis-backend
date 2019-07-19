# frozen_string_literal: true

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
