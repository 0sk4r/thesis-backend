# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mention, type: :model do
  describe 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:comment) }
  end
end
