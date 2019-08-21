require 'faker'

# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first

# Create sample user
user1 = User.new(nickname: 'test', email: 'test@test.pl', password: 'test123', name: 'test')
user2 = User.new(nickname: 'test2', email: 'test2@test.pl', password: 'test123', name: 'test2')
user1.save
user2.save
user1.confirm
user2.confirm

# Create category
Category.create(name: 'News')
Category.create(name: 'Tech')
Category.create(name: 'Blockchain')
Category.create(name: 'Style')
Category.create(name: 'Politics')

(1..5).each do |category|
  (1..5).each do |_x|
    Post.create(title: Faker::Lorem.sentence, content: Faker::Hacker.say_something_smart, category_id: category, user_id: user1.id)
    Post.create(title: Faker::Lorem.sentence, content: Faker::Hacker.say_something_smart, category_id: category, user_id: user2.id)
  end
end
