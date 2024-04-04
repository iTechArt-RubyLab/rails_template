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
class ApiUserSerializer
  include JSONAPI::Serializer

  attributes :id, :email

  attribute :created_date do |user|
    user&.created_at.strftime('%a, %e %b %Y %H:%M:%S %z')
  end
end
