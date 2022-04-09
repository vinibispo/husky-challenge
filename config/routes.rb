Rails.application.routes.draw do
  modular_routes do
    resources :invoices do
      get :logout, on: :collection
    end

    resources :users, only: %i[create new]
    resources :tokens
  end
  root 'tokens/index#call'
end
