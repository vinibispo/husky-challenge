# edit controller for invoices
class Invoices::EditController < ApplicationController
  def call

    invoice = Invoice.find(params[:id])
    render 'invoices/edit', locals: { invoice: }
  end
end
