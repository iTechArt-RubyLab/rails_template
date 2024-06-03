# frozen_string_literal: true

class RemoveIndexUsersRolesOnUserIdIndex < ActiveRecord::Migration[7.1]
  def change
    remove_index nil, name: 'index_users_roles_on_user_id'
  end
end
