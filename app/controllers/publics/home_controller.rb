# home controller for publics
class Publics::HomeController < ApplicationController
  def call
    Invoice::GetToken.call(token: session[:current_user_token])
                     .then(&:data)
                     .then(&Invoice::GetAuthentication)
                     .on_success { redirect_to invoices_path }
                     .on_failure { render 'publics/home' }
  end
end
