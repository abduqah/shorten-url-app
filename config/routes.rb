Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :urls, only: :create do
        collection do
          post 'original'
        end
      end
    end
  end
end
