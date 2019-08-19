# frozen_string_literal: true

class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :action_type, :created_at
  belongs_to :action
end
