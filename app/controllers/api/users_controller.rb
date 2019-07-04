# frozen_string_literal: true

module Api
  class UsersController < ApplicationController
    def find
      provider = UserProvider.new(params[:key])
      render json: provider.results
    end
  end
end
  