# frozen_string_literal: true

class DeviseCreateApiUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :api_users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''
      t.string :jti,                null: false

      t.timestamps                  null: false
    end

    add_index :api_users, :email, unique: true
    add_index :api_users, :jti,   unique: true
  end
end
