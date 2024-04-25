# frozen_string_literal: true

module Api
  module V1
    class ChartsController < AuthenticatedApplicationController
      def data
        render json: {
          target: 46,
          current: 34,
          baseline: 452.18,
          targetTonnes: 300,
          firstStage: 55,
          firstStageVehicle: 27,
          firstStagePropulsion: 33,
          firstStageAvionics: 20,
          firstStageThermal: 10,
          firstStageAuxiliary: 10,
          firstStageDesign: 32,
          firstStageManufacture: 20,
          firstStageTesting: 5,
          firstStageFlight: 15,
          firstStageEnd: 28,
          secondStage: 26,
          secondStageVehicle: 33,
          secondStagePropulsion: 20,
          secondStageAvionics: 27,
          secondStageThermal: 15,
          secondStageAuxiliary: 5,
          secondStageDesign: 18,
          secondStageManufacture: 42,
          secondStageTesting: 17,
          secondStageFlight: 3,
          secondStageEnd: 20,
          fairing: 19,
          fairingStageVehicle: 21,
          fairingStagePropulsion: 39,
          fairingStageAvionics: 7,
          fairingStageThermal: 20,
          fairingStageAuxiliary: 13,
          fairingStageDesign: 10,
          fairingStageManufacture: 50,
          fairingStageTesting: 5,
          fairingStageFlight: 10,
          fairingStageEnd: 25,
          accuracy: 64
        }, status: :ok
      end
    end
  end
end
