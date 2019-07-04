# frozen_string_literal: true

class Comment < ApplicationRecord
  after_create :create_mentions

  belongs_to :post
  belongs_to :user

  validates_presence_of :content

  def create_mentions(comment_id: self.id, content: self.content)
    MentionsWorker.perform_async(comment_id, content)
  end
end
