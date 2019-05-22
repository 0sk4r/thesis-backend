# frozen_string_literal: true

class CreateLike < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.integer :like_type
    end
  end
end
