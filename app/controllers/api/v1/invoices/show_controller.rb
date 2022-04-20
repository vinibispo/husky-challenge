# show controller for invoices in api
class Api::V1::Invoices::ShowController < ApplicationController
  def call
    authenticate_or_request_with_http_token do |token|
      Invoice::Show::Authorized::Flow.call(token:, id: params[:id])
                                     .on_failure(:no_token) { render_unauthorized }
                                     .on_failure(:not_found) { render_not_found }
                                     .on_success { |result| render_invoice(result) }
    end
  end

  private

  def render_unauthorized
    head :unauthorized
  end

  def render_not_found
    head :not_found
  end

  def render_invoice(result)
    render 'invoices/show', locals: { invoice: result[:invoice] }, formats: [:json]
  end
end
