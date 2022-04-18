class Invoices::SendEmailsController < ApplicationController
  def call
    Invoice::SendEmails::Flow
      .call(token: session[:current_user_token], params:)
      .on_failure(:invalid_attributes) { redirect_no_token_error }
      .on_failure(:no_token) { |error| redirect_error(error[:message]) }
      .on_failure(:no_emails) { |error| redirect_invoice_error(error[:message]) }
      .on_failure(:no_valid_emails) { |error| redirect_invoice_error(error[:message]) }
      .on_failure(:not_found) { render_not_found }
      .on_success { |result| redirect_invoices(result[:invoice]) }
  end

  private

  def redirect_invoices(invoice)
    flash[:success] = I18n.t("flash.invoices.send_emails.success")
    redirect_to invoice
  end

  def redirect_error(message)
    redirect_to root_path
    flash[:danger] = message
  end

  def redirect_invoice_error(message)
    redirect_to invoice_path(params[:id])
    flash[:danger] = message
  end

  def redirect_no_token_error
    redirect_to root_path
    flash[:danger] = I18n.t('flash.user.unauthorized')
  end

  def render_not_found
    render file: 'public/404.html', status: :not_found
  end
end
