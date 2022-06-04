Rails.application.routes.draw do
  root '\campaigns', controller: :campaigns, action: :index

  resources :campaigns, only: %i(index show) do
    resources :investments, only: [:create, :new]
  end
end
