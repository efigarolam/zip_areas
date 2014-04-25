class DemoController < ApplicationController
  def index
    @zip_codes = params[:zip_codes]
  end
end

