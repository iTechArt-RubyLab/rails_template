# frozen_string_literal: true

class CreateUsersWithRoles < ActiveRecord::Migration[7.1]
  def change
    create_view :users_with_roles
  end
end
