class Api::V1::Invoices::CreateController < Api::V1::ApplicationController
  def call
    authenticate_or_request_with_http_token do |token|
      Invoice::Create::Flow.call(token:, params:)
                           .on_failure(:no_token) { render_unauthorized }
                           .on_failure(:invoice_error) { |data| render json: data[:invoice].errors, status: :unprocessable_entity }
                           .on_success { |data| render 'invoices/show', format: [:json], locals: { invoice: data[:invoice] } }
    end
  end

  private

  def render_unauthorized
    head :unauthorized
  end
end
