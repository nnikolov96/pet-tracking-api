Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :pets, only: [ :create ]

      namespace :pets do
        get "report", to: "reports#show", as: :report
      end
    end
  end
end
