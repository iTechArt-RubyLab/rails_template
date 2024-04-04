# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if @user.has_role?(ROLES[:admin])
        scope.all
      else
        scope.without_role(ROLES[:admin])
      end
    end
  end

  def index?
    @user.has_any_role?(ROLES[:admin], ROLES[:viewer])
  end

  def show?
    update? || (@record.id == @user.id)
  end

  def edit?
    update?
  end

  def update?
    @user.has_role?(ROLES[:admin])
  end
end
