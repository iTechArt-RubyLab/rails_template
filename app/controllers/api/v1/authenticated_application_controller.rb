# frozen_string_literal: true

module Api
  module V1
    class AuthenticatedApplicationController < ActionController::Base
      before_action :authenticate_api_user!
    end
  end
end
