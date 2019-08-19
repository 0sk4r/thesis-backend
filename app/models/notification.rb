# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id          :bigint           not null, primary key
#  user_id     :bigint
#  action_type :string
#  action_id   :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :action, polymorphic: true
end
