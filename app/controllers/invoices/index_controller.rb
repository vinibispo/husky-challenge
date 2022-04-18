# index controller for invoice
class Invoices::IndexController < ApplicationController
  def call
    ::Invoice::Fetch::Flow.call(token: session[:current_user_token], params:)
                          .on_failure(:invalid_attributes) { redirect_no_token_error }
                          .on_failure(:no_token) { |error| redirect_error(error[:message]) }
                          .on_success { |data| render_successfully(data) }
  end

  private

  def redirect_error(message)
    redirect_to root_path
    flash[:danger] = message
  end

  def redirect_no_token_error
    redirect_to root_path
    flash[:danger] = I18n.t('flash.user.unauthorized')
  end

  def render_successfully(data)
    render 'invoices/index', locals: { invoices: data[:invoices], q: data[:q] }
  end
end
