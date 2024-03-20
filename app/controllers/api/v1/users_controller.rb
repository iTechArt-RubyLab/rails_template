# frozen_string_literal: true

module Api
  module V1
    class UsersController < AuthenticatedApplicationController
      def index
        render json: User.all.order(:created_at).map { |user| serialize!(user) }, status: :ok
      end

      def show
        render json: serialize!(User.find_by_id(params[:id])), status: :ok
      end

      def current_user
        render json: serialize!(current_api_user), status: :ok
      end

      private

      def serialize!(user)
        return {} unless user

        ApiUserSerializer.new(user).serializable_hash[:data][:attributes]
      end
    end
  end
end
