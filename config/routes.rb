Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "categories#index"

  resources :categories do
    resources :recipes, only: [:show] do
      resources :bookmarks, only: [:new, :create, :edit, :update, :destroy] do
        member do
          get 'edit_comment' # Route for editing a comment
          patch 'update_comment' # Route for updating a comment
        end
      end
    end
  end
end
