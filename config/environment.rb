# frozen_string_literal: true

# Load the Rails application.
require_relative 'application'

require 'carrierwave/orm/activerecord'
require 'carrierwave'

# Initialize the Rails application.
Rails.application.initialize!

# Settings for sendgrid
ActionMailer::Base.smtp_settings = {
  user_name: 'apikey',
  password: Rails.application.credentials.sendgrid[:apikey],
  domain: 'yourdomain.com',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  enable_starttls_auto: true
}
