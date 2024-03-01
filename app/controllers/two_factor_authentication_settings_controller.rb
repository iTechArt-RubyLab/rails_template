# frozen_string_literal: true

class TwoFactorAuthenticationSettingsController < ApplicationController
  def new
    if current_user.otp_required_for_login
      flash[:alert] = I18n.t('two_factor_auth_settings.already_enabled')

      return redirect_to edit_user_registration_path
    end

    current_user.generate_two_factor_auth_secret_if_missing!
  end

  def create
    unless current_user.valid_password?(two_factor_auth_params[:password])
      flash.now[:alert] = I18n.t('two_factor_auth_settings.password_invalid')

      return render :new
    end

    if current_user.validate_and_consume_otp!(two_factor_auth_params[:code])
      current_user.enable_two_factor_auth!

      flash[:notice] = I18n.t('two_factor_auth_settings.two_factor_auth_enabled')

      redirect_to edit_two_factor_authentication_settings_path
    else
      flash.now[:alert] = I18n.t('two_factor_auth_settings.two_factor_auth_code_invalid')

      render :new
    end
  end

  def edit
    unless current_user.otp_required_for_login
      flash[:alert] = I18n.t('two_factor_auth_settings.enable_two_factor_auth')

      return redirect_to new_two_factor_authentication_settings_path
    end

    if current_user.two_factor_auth_backup_codes_generated?
      flash[:alert] = I18n.t('two_factor_auth_settings.backup_codes_seen')

      return redirect_to edit_user_registration_path
    end

    @backup_codes = current_user.generate_otp_backup_codes!

    current_user.save!
  end

  def destroy
    if current_user.disable_two_factor_auth!
      flash[:notice] = I18n.t('two_factor_auth_settings.two_factor_auth_disabled')

      redirect_to edit_user_registration_path
    else
      flash[:alert] = I18n.t('two_factor_auth_settings.could_not_disable_two_factor_auth')

      redirect_to root_path
    end
  end

  private

  def two_factor_auth_params
    @two_factor_auth_params ||= params.require(:two_factor_auth).permit(:code, :password)
  end
end
