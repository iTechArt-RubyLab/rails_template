# frozen_string_literal: true

module Api
  module V1
    class ChartsController < AuthenticatedApplicationController
      def data
        render json: { chart_1: { a: 1, b: 2 }, chart_2: { a: 3, b: 4 } }, status: :ok
      end
    end
  end
end
