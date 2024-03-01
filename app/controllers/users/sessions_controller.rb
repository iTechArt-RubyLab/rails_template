# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    include AuthenticateWithOtpTwoFactor

    prepend_before_action :authenticate_with_otp_two_factor_auth, if: -> do
      action_name == 'create' && otp_two_factor_auth_enabled?
    end

    before_action :configure_sign_in_params, only: %i(create)

    # GET /resource/sign_in
    # def new
    #   super
    # end

    # POST /resource/sign_in
    # def create
    #   super
    # end

    # DELETE /resource/sign_out
    # def destroy
    #   super
    # end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: %i(otp_attempt))
    end
  end
end
