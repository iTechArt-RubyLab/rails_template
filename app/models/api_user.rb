# frozen_string_literal: true

# == Schema Information
#
# Table name: api_users
#
#  id                 :bigint           not null, primary key
#  email              :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  jti                :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_api_users_on_email  (email) UNIQUE
#  index_api_users_on_jti    (jti) UNIQUE
#
class ApiUser < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,
         :registerable,
         :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :jti, presence: true

  def jwt_payload
    super
  end
end
