# frozen_string_literal: true

class AddProviderEmailUniqueIndexToUsers < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def up
    remove_index :users, :email, unique: true, algorithm: :concurrently
    add_index :users, %i(provider email), unique: true, algorithm: :concurrently
  end

  def down
    remove_index :users, %i(provider email), unique: true, algorithm: :concurrently
    add_index :users, :email, unique: true, algorithm: :concurrently
  end
end
