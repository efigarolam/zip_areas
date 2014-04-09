module Api
  module V1
    class CoordinatesController < Api::V1::BaseController
      def index
        render json: coordinates, status: 200
      end

      def show
        render json: coordinate, status: 200
      end

      private

      def coordinate_params
        params.require(:coordinate).permit(
          :longitude,
          :latitude,
          :zipcode_id
        )
      end

      def coordinate
        @coordinate ||= Coordinate.find(params[:id])
      end

      def coordinates
        @coordinates ||= Coordinate.all
      end
    end
  end
end

