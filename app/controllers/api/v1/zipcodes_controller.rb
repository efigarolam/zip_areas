module Api
  module V1
    class ZipcodesController < Api::V1::BaseController
      expose(:zipcode, attributes: :zipcode_params)
      expose(:new_zipcode) { zipcodes.build(zipcode_params) }
      expose(:zipcodes)

      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      def index
        render json: zipcodes, status: 200
      end

      def show
        render json: zipcode, status: 200
      end

      def create
        if new_zipcode.save
          render nothing: true, status: 204
        else
          render json: new_zipcode.errors, status: 422
        end
      end

      private

      def zipcode_params
        params.require(:zipcode).permit(
          :name
        )
      end

      def record_not_found
        render json: { error: "Sorry, but this record doesn't exist"},
          status: 404
      end
    end
  end
end
