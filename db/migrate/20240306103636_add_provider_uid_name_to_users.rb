# frozen_string_literal: true

class AddProviderUidNameToUsers < ActiveRecord::Migration[7.1]
  disable_ddl_transaction!

  def up
    %i(provider uid name).each { |column| add_column :users, column, :string }

    add_index :users, %i(provider uid), unique: true, algorithm: :concurrently
  end

  def down
    remove_index :users, %i(provider uid), unique: true, algorithm: :concurrently

    %i(name uid provider).each { |column| safety_assured { remove_column :users, column, :string } }
  end
end
