# frozen_string_literal: true

class AddCategoryToPosts < ActiveRecord::Migration[5.2]
  def change
    add_reference :posts, :category, foreign_key: true
  end
end
