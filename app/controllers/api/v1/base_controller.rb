class Api::V1::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def record_not_found
    render json: { error: "Sorry, but this record doesn't exist"},
      status: 404
  end
end

