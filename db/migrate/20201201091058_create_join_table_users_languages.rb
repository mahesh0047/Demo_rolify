# frozen_string_literal: true

class CreateJoinTableUsersLanguages < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :languages do |t|
      t.index :user_id
      t.index :language_id
    end
  end
end
