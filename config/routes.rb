Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  modular_routes do
    resources :invoices, only: %i[index new create show] do
      put :send_emails, on: :member
    end

    resources :users, only: %i[create] do
      get :register, on: :collection
    end
    resources :publics, only: [] do
      get :home, on: :collection
    end
    resources :sessions, only: %i[new create destroy]

    namespace :api do
      namespace :v1 do
        resources :invoices, only: %i[index create show] do
          put :send_emails, on: :member
        end
      end
    end
  end

  root 'publics/home#call'
end
