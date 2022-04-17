Rails.application.routes.draw do
  modular_routes do
    resources :invoices, only: %i[index new create show]

    resources :users, only: %i[create] do
      get :register, on: :collection
    end
    resources :publics, only: [] do
      get :home, on: :collection
    end
    resources :sessions, only: %i[new create destroy]
  end

  root 'publics/home#call'
end
