module Api
  module V1
    class ZipcodesController < Api::V1::BaseController
      def index
        render json: zipcodes.to_json(include: :coordinates), status: 200
      end

      def show
        render json: zipcode.to_json(include: :coordinates), status: 200
      end

      private

      def zipcode_params
        params.require(:zipcode).permit(
          :name
        )
      end

      def zipcode
        @zipcode ||= Zipcode.find(params[:id])
      end

      def zipcodes
        @zipcodes ||= Zipcode.all
      end
    end
  end
end

