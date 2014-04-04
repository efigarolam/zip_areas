ZipAreas::Application.routes.draw do
  root 'demo#index'

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :zipcodes, except: [:new, :edit]
      resources :coordinates, except: [:new, :edit]
    end
  end
end
