# frozen_string_literal: true

# Notification serializer
class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :action_type, :created_at
  belongs_to :action
end
