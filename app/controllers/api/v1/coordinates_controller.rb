module Api
  module V1
    class CoordinatesController < Api::V1::BaseController
      expose(:coordinate, attributes: :coordinate_params)
      expose(:coordinates)

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      def index
        render json: coordinates, status: 200
      end

      def show
        render json: coordinate, status: 200
      end

      def create
        if coordinate.save
          render json: "", status: 204
        else
          render json: coordinate.errors, status: 422
        end
      end

      def update
        if coordinate.update(coordinate_params)
          render json: "", status: 204
        else
          render json: coordinate.errors, status: 422
        end
      end

      def destroy
        if coordinate.destroy
          render json: "", status: 204
        end
      end

      private

      def coordinate_params
        params.require(:coordinate).permit(
          :longitude,
          :latitude,
          :zipcode_id
        )
      end

      def record_not_found
        render json: { error: "Sorry, but this record doesn't exist"},
          status: 404
      end
    end
  end
end
