Rails.application.routes.draw do
  resources :campaigns, only: %i(index show) do
    resources :investments, only: :create
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
