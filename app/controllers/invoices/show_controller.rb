# show controller for invoices
class Invoices::ShowController < ApplicationController
  def call
    invoice = Invoice.find(params[:id])
    render 'invoices/show', locals: { invoice: }
  end
end
