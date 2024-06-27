# frozen_string_literal: true

ActiveAdmin.register Admin::UsersWithRole do
  menu label: 'UsersWithRole'

  actions :index

  index title: 'Users with Role' do
    column :name
    column :email
    column :provider
    column :role
  end
end
