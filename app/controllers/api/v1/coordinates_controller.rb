class Api::V1::CoordinatesController < Api::V1::BaseController
  expose(:coordinate, attributes: :coordinate_params)
  expose(:coordinates)

  def index
    respond_to do |format|
      format.json { render json: coordinates, status: 200 }
      format.xml { render json: coordinates, status: 200 }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: coordinate, status: 200 }
      format.xml { render json: coordinate, status: 200 }
    end
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def coordinate_params
    params(:coordinate).permit(
      :longitude,
      :latitude,
      :zipcode
    )
  end
end
