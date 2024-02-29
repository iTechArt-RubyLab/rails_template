# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  consumed_timestep      :integer
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  failed_attempts        :integer          default(0), not null
#  invitation_accepted_at :datetime
#  invitation_created_at  :datetime
#  invitation_limit       :integer
#  invitation_sent_at     :datetime
#  invitation_token       :string
#  invitations_count      :integer          default(0)
#  invited_by_type        :string
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  locked_at              :datetime
#  otp_backup_codes       :string           is an Array
#  otp_required_for_login :boolean
#  otp_secret             :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
class User < ApplicationRecord
  devise *%i(
            invitable
            registerable
            recoverable
            rememberable
            validatable
            confirmable
            lockable
            timeoutable
            trackable
            omniauthable
          )

  # devise :database_authenticatable

  devise :two_factor_authenticatable,
         :two_factor_backupable,
         otp_backup_code_length: 16,
         otp_number_of_backup_codes: 10,
         otp_secret_encryption_key: ENV['OTP_SECRET_KEY']

  has_many :invitees, class_name: 'User', foreign_key: :invited_by_id

  def generate_two_factor_auth_secret_if_missing!
    otp_secret.blank? && update!(otp_secret: User.generate_otp_secret)
  end

  def enable_two_factor_auth!
    update!(otp_required_for_login: true)
  end

  def disable_two_factor_auth!
    update!(otp_required_for_login: false, otp_secret: nil, otp_backup_codes: nil)
  end

  def two_factor_auth_qr_code_uri
    issuer = ENV['OTP_TWO_FACTOR_AUTHENTICATION_ISSUER_NAME']
    label = [issuer, email].join(':')

    otp_provisioning_uri(label, issuer: issuer)
  end

  def two_factor_auth_backup_codes_generated?
    otp_backup_codes.present?
  end
end
