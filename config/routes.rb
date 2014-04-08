ZipAreas::Application.routes.draw do
  root 'demo#index'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :zipcodes, only: [:show, :index]
      resources :coordinates, only: [:show, :index]
    end
  end
end

