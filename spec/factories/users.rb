# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    nickname { Faker::Internet.username }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirmed_at { Time.now }
  end
end
