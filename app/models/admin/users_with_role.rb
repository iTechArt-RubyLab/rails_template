# frozen_string_literal: true

# == Schema Information
#
# Table name: users_with_roles
#
#  email    :string
#  name     :string
#  provider :string
#  role     :string
#
module Admin
  class UsersWithRole < ApplicationRecord
    self.table_name = 'users_with_roles'

    def self.ransackable_attributes(_auth_object = nil)
      %w(email name provider role)
    end
  end
end
