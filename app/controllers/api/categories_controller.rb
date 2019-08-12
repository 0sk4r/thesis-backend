# frozen_string_literal: true

module Api
  class CategoriesController < ApplicationController
    def index
      @categories = Category.all
      render json: @categories, include: ['category']
    end

    def show
      @category = Category.find(params[:id])
      render json: @category, include: ['posts.user', 'posts.category']
    end
  end
end
