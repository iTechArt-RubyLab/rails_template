# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id            :bigint           not null, primary key
#  name          :string
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :bigint
#
# Indexes
#
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#  index_roles_on_resource                                (resource_type,resource_id)
#
class Role < ApplicationRecord
  MANAGER = 'manager'.freeze
  ADMIN = 'admin'.freeze
  VIEWER = 'viewer'.freeze

  has_and_belongs_to_many :users, join_table: :users_roles
  
  belongs_to :resource, polymorphic: true, optional: true

  validates :resource_type, inclusion: { in: Rolify.resource_types }, allow_nil: true

  scopify

  def self.ransackable_attributes(_auth_object = nil)
    %w(
      id
      id_value
      name
      resource_id
      resource_type
      created_at
      updated_at
    )
  end
end
