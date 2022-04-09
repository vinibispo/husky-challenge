# logout controller for invoices
class Invoices::LogoutController < ApplicationController
  def call
    return redirect_if_is_not_authenticated if not_authenticated_and_html?

    session.delete(:current_user_token)

    redirect_to(root_path)
  end
end
