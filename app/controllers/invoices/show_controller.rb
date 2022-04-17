# show controller for invoices
class Invoices::ShowController < ApplicationController
  def call
    Invoice::Show::Flow.call(id: params[:id], token: session[:current_user_token])
                       .on_failure(:not_found) { render_not_found }
                       .on_success { |result| render_invoice(result[:invoice]) }
  end

  private

  def render_invoice(invoice)
    render 'invoices/show', locals: { invoice: }
  end

  def render_not_found
    render file: 'public/404.html', status: :not_found, layout: false
  end
end
