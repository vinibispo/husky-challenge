Rails.application.routes.draw do
  modular_routes do
    resources :invoices do
      get :logout, on: :collection
    end

    resources :users, only: %i[create] do
      get :register, on: :collection
    end
    resources :tokens
    resources :sessions, only: %i[new create destroy]
  end
  root 'tokens/index#call'
end
