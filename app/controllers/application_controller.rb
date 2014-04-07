class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end
end
