# frozen_string_literal: true

class AddDeviseTwoFactorBackupableToUsers < ActiveRecord::Migration[7.1]
  def up
    # Change type from :string to :text if using MySQL database
    add_column :users, :otp_backup_codes, :string, array: true
  end

  def down
    safety_assured { remove_column :users, :otp_backup_codes, :string, array: true }
  end
end
