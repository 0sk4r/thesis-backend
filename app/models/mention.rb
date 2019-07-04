# frozen_string_literal: true

class Mention < ApplicationRecord
  belongs_to :comment
  belongs_to :user
end
