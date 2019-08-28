# frozen_string_literal: true

class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.references :follower
      t.references :following

      t.timestamps
    end

    add_foreign_key :follows, :users, column: :follower_id, primary_key: :id
    add_foreign_key :follows, :users, column: :following_id, primary_key: :id
  end
end
