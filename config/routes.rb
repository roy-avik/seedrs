Rails.application.routes.draw do
  resources :campaigns, only: %i(index show) do
    resources :investments, only: :create
  end
end
