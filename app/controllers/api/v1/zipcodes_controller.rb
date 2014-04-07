module Api
  module V1
    class ZipcodesController < Api::V1::BaseController
      expose(:zipcode, attributes: :zipcode_params)
      expose(:new_zipcode) { zipcodes.build(zipcode_params) }
      expose(:zipcodes)

      def index
        render json: zipcodes, status: 200
      end

      def show
        render json: zipcode, status: 200
      end

      def create
        if new_zipcode.save
          render json: "", status: 204
        else
          render json: new_zipcode.errors, status: 422
        end
      end

      def update
        if zipcode.update(zipcode_params)
          render json: "", status: 204
        else
          render json: zipcode.errors, status: 422
        end
      end

      def destroy
        if zipcode.destroy
          render json: "", status: 204
        end
      end

      private

      def zipcode_params
        params.require(:zipcode).permit(
          :name
        )
      end
    end
  end
end

