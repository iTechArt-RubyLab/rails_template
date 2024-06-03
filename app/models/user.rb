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
#  name                   :string
#  otp_backup_codes       :string           is an Array
#  otp_required_for_login :boolean          default(FALSE), not null
#  otp_secret             :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  uid                    :string
#  unconfirmed_email      :string
#  unlock_token           :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  invited_by_id          :bigint
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email_and_provider    (email,provider) UNIQUE
#  index_users_on_invitation_token      (invitation_token) UNIQUE
#  index_users_on_invited_by            (invited_by_type,invited_by_id)
#  index_users_on_invited_by_id         (invited_by_id)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (invited_by_id => users.id)
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
          )

  # devise :database_authenticatable

  devise :two_factor_authenticatable,
         :two_factor_backupable,
         otp_backup_code_length: 16,
         otp_number_of_backup_codes: 10,
         otp_secret_encryption_key: ENV['OTP_SECRET_KEY']

  devise :omniauthable, omniauth_providers: %i(google_oauth2 github)

  rolify

  after_create :assign_default_role

  has_many :invitees, class_name: 'User', foreign_key: :invited_by_id

  validate :role_should_be_present, on: :update

  validates :uid, uniqueness: { scope: :provider }, allow_nil: true
  validates :email, presence: true, uniqueness: { scope: :provider }

  %i(invitation_token confirmation_token unlock_token reset_password_token).each do |token|
    validates token, uniqueness: true, allow_nil: true
  end

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

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name

      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      user.skip_confirmation!
    end
  end

  def devise_will_save_change_to_email?
    false
  end

  def allowed_to_access_dashboards?
    has_role?(Role::MANAGER)
  end

  def self.ransackable_associations(_auth_object = nil)
    %w(invited_by invitees roles)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w(
      confirmation_sent_at
      confirmation_token
      confirmed_at
      consumed_timestep
      created_at
      current_sign_in_at
      current_sign_in_ip
      email
      encrypted_password
      failed_attempts
      id
      id_value
      invitation_accepted_at
      invitation_created_at
      invitation_limit
      invitation_sent_at
      invitation_token
      invitations_count
      invited_by_id
      invited_by_type
      last_sign_in_at
      last_sign_in_ip
      locked_at
      name
      otp_backup_codes
      otp_required_for_login
      otp_secret
      provider
      remember_created_at
      reset_password_sent_at
      reset_password_token
      sign_in_count
      uid
      unconfirmed_email
      unlock_token updated_at
    )
  end

  private

  def assign_default_role
    self.add_role(Role::VIEWER) if self.roles.blank?
  end

  def role_should_be_present
    errors.add(:roles, I18n.t('roles.should_be_present')) if roles.blank?
  end
end
