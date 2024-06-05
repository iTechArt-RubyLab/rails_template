# frozen_string_literal: true

class AddDeviseTwoFactorToUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :otp_secret, :string
    add_column :users, :consumed_timestep, :integer
    add_column :users, :otp_required_for_login, :boolean, null: false, default: false
  end

  def down
    safety_assured { remove_column :users, :otp_required_for_login, :boolean }
    safety_assured { remove_column :users, :consumed_timestep, :integer }
    safety_assured { remove_column :users, :otp_secret, :string }
  end
end
