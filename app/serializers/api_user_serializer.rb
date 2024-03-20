# frozen_string_literal: true

class ApiUserSerializer
  include JSONAPI::Serializer

  attributes :id, :email

  attribute :created_date do |user|
    user&.created_at.strftime('%a, %e %b %Y %H:%M:%S %z')
  end
end
