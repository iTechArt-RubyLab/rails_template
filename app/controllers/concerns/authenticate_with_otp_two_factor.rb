# frozen_string_literal: true

module AuthenticateWithOtpTwoFactor
  extend ActiveSupport::Concern

  def authenticate_with_otp_two_factor_auth
    user = self.resource = found_user

    if user_params[:otp_attempt].present? && session[:otp_user_id]
      authenticate_user_with_otp_two_factor_auth(user)
    elsif user&.valid_password?(user_params[:password])
      prompt_for_otp_two_factor_auth(user)
    end
  end

  private

  def authenticate_user_with_otp_two_factor_auth(user)
    if valid_otp_attempt?(user)
      # Remove any lingering user data from login
      session.delete(:otp_user_id)

      remember_me(user) if user_params[:remember_me] == '1'

      user.save!

      sign_in(user, event: :authentication)
    else
      flash.now[:alert] = I18n.t('two_factor_auth_settings.two_factor_auth_code_invalid')

      prompt_for_otp_two_factor_auth(user)
    end
  end

  def valid_otp_attempt?(user)
    user.validate_and_consume_otp!(user_params[:otp_attempt]) || user.invalidate_otp_backup_code!(user_params[:otp_attempt])
  end

  def prompt_for_otp_two_factor_auth(user)
    @user = user

    session[:otp_user_id] = user.id

    render 'devise/sessions/two_factor_authentication'
  end

  def otp_two_factor_auth_enabled?
    found_user&.otp_required_for_login
  end

  def found_user
    @found_user ||= begin
      if session[:otp_user_id]
        User.find(session[:otp_user_id])
      elsif user_params[:email]
        User.find_by(email: user_params[:email]).tap { |user| session[:otp_user_id] = user.id if user }
      end
    end
  end

  def user_params
    @user_params ||= params.require(:user).permit(:email, :password, :remember_me, :otp_attempt)
  end
end
