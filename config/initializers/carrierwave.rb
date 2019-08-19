# frozen_string_literal: true

CarrierWave.configure do |config|
  # config.fog_provider = "fog-google"
  config.fog_credentials = {
    provider: 'Google',
    google_storage_access_key_id: Rails.application.credentials.google2[:key],
    google_storage_secret_access_key: Rails.application.credentials.google2[:secret]
  }
  config.fog_directory = 'thesis-db'
end
