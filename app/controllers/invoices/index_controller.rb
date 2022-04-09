# index controller for invoice
class Invoices::IndexController < ApplicationController
  def call
    return redirect_if_is_not_authenticated if not_authenticated_and_html?

    invoices = Invoice.all
    render 'invoices/index', locals: { invoices: }
  end
end
