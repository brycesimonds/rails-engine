Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find_all', to: 'merchant_searches#index'
      resources :merchants, only: [:index, :show] do
        get '/items', to: 'merchants#items'
      end
      resources :items do 
        get '/merchant', to: 'items#merchant'
      end
    end
  end
end
