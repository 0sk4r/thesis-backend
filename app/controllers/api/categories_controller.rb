# frozen_string_literal: true

module Api
  class CategoriesController < ApplicationController
    # Api for managing categories

    # GET /api/categories List of categories
    # Response with array of categories:
    #   [
    #     {
    #         "id": Integer, #Category ID
    #         "name": String #Category name
    #     },..
    # ]
    def index
      @categories = Category.all
      render json: @categories, include: ['category']
    end

    # GET /api/categories/:id get posts list in selected category
    # prams: :id category id
    # Response with:
    #   {
    #     "id": Integer, #Category ID
    #     "name": String, #Category name
    #     "posts": [
    #         #Lists of post objects
    #     ]
    # }
    def show
      @category = Category.find(params[:id])
      render json: @category, include: ['posts.user', 'posts.category']
    end
  end
end
