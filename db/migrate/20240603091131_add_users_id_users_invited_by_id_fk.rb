# frozen_string_literal: true

class AddUsersIdUsersInvitedByIdFk < ActiveRecord::Migration[7.1]
  def up
    add_foreign_key :users, :users, column: :invited_by_id, primary_key: :id
  end

  def down
    remove_foreign_key :users, :users, column: :invited_by_id, primary_key: :id
  end
end
