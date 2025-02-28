# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update)

  def index
    @users = policy_scope(User).includes(:roles).order(created_at: :desc).page(params[:page])

    authorize @users
  end

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user

    if @user.update(user_params)
      redirect_to users_url, notice: I18n.t('users.successfully_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(role_ids: [])
  end
end
