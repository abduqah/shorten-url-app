Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Raddocs::App => "/docs"

  root 'urls#new'

  resources :urls, param: :short_url, only: %i[new create show] do
    collection do
      get 'originate_url'
      post 'original'
    end
  end

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      resources :urls, only: :create do
        collection do
          post 'original'
        end
      end
    end
  end
end
