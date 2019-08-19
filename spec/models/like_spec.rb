# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:like_type) }
  end

  describe 'association' do
    it { should belong_to(:post) }
  end
end
