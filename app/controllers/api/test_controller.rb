# frozen_string_literal: true

module Api
  class TestController < ApplicationController
    before_action :authenticate_user!, only: [:test]
    def index
      render json: { "test": 'testowa' }
    end

    def test
      render json: { "test": 'protected' }
    end
  end
end
