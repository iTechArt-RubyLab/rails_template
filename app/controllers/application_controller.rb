# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = I18n.t('authorization.not_authorized')

    redirect_to(request.referrer || root_path)
  end
end
