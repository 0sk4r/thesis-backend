# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :user
  belongs_to :comment

  has_one :notification, as: :action
end
