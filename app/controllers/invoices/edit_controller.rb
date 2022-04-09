# edit controller for invoices
class Invoices::EditController < ApplicationController
  def call
    return redirect_if_is_not_authenticated if not_authenticated_and_html?

    invoice = Invoice.find(params[:id])
    render 'invoices/edit', locals: { invoice: }
  end
end
