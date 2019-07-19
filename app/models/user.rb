# frozen_string_literal: true

class User < ActiveRecord::Base
  mount_uploader :image, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User

  validates :email, :encrypted_password, :nickname, :name, presence: true

  has_many :posts
  has_many :notifications
end
