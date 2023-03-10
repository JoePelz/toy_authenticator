Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [] do
    collection do
      post :authenticate
    end
  end

  namespace :admin do
    resources :users, only: [:create] do
      collection do
        get :find
      end
    end
  end
end
