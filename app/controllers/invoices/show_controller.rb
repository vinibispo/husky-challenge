# show controller for invoices
class Invoices::ShowController < ApplicationController
  def call
    return redirect_if_is_not_authenticated if not_authenticated_and_html?

    @invoice = Invoice.find(params[:id])
    render 'invoices/show'
  end
end
