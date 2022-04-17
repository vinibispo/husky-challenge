# new controller for invoices
class Invoices::NewController < ApplicationController
  def call
    ::Invoice::New::Flow.call(token: session[:current_user_token])
                        .on_failure(:invalid_attributes) { redirect_no_token_error }
                        .on_failure(:no_token) { |error| redirect_error(error[:message]) }
                        .on_success do |result|
      render 'invoices/new', locals: { invoice: result[:invoice] }
    end
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
end
