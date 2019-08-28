# frozen_string_literal: true

# Mention serializer
class MentionSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :comment
  belongs_to :user
end
