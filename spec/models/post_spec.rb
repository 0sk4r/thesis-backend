# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe 'association' do
    it { should belong_to(:user) }
    it { should have_many(:comment) }
    it { should have_many(:like) }
  end
end
