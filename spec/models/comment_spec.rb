# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
  end

  describe 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
