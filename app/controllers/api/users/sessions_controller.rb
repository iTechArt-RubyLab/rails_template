# frozen_string_literal: true

module Api
  module Users
    class SessionsController < Devise::SessionsController
      skip_before_action :verify_authenticity_token

      respond_to :json

      # before_action :configure_sign_in_params, only: [:create]

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

      # protected

      # If you have extra params to permit, append them to the sanitizer.
      # def configure_sign_in_params
      #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
      # end

      private

      def respond_with(resource, _opts = {})
        render json: {
          status: {
            code: 201,
            message: I18n.t('devise.sessions.signed_in'),
            data: ApiUserSerializer.new(resource).serializable_hash[:data][:attributes]
          }
        }, status: :created
      end

      def respond_to_on_destroy
        if current_api_user
          render json: { message: I18n.t('devise.sessions.signed_out') }, status: :ok
        else
          render json: { message: I18n.t('devise.sessions.no_active_session_found') }, status: :unauthorized
        end
      end
    end
  end
end
