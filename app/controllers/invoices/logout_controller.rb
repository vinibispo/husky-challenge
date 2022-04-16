# logout controller for invoices
class Invoices::LogoutController < ApplicationController
  def call

    session.delete(:current_user_token)

    redirect_to(root_path)
  end
end
