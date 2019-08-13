# frozen_string_literal: true

# == Schema Information
#
# Table name: mentions
#
#  id         :bigint           not null, primary key
#  comment_id :bigint
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Mention < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  has_one :notification, as: :action
end
