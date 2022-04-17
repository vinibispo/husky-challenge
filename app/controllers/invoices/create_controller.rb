# frozen_string_literal: true

# create controller for invoices
class Invoices::CreateController < ApplicationController
  def call
    ::Invoice::Create::Flow.call(token: session[:current_user_token], params:)
                           .on_failure(:invalid_attributes) { redirect_no_token_error }
                           .on_failure(:no_token) { |error| redirect_error(error[:message]) }
                           .on_failure(:invoice_error) { |error| render_error(error) }
                           .on_success { |data| redirect_successfully(data) }
  end

  private

  def render_error(data)
    render 'invoices/new', locals: { invoice: data[:invoice] }
  end

  def redirect_error(message)
    redirect_to root_path
    flash[:danger] = message
  end

  def redirect_no_token_error
    redirect_to root_path
    flash[:danger] = I18n.t('flash.user.unauthorized')
  end

  def redirect_successfully(data)
    redirect_to invoice_url(data[:invoice])
    flash[:success] = data[:message]
  end
end
