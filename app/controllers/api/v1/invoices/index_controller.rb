# index controller for invoices in api
class Api::V1::Invoices::IndexController < Api::V1::ApplicationController
  def call
    authenticate_or_request_with_http_token do |token|
      ::Invoice::Fetch::Flow.call(token:, params:)
                            .on_failure(:no_token) { render_unauthorized }
                            .on_success { |data| render_successfully(data) }
    end
  end

  private

  def render_unauthorized
    head :unauthorized
  end

  def render_successfully(data)
    render 'invoices/index', locals: { invoices: data[:invoices] }, formats: [:json]
  end
end
