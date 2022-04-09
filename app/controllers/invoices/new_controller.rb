# new controller for invoices
class Invoices::NewController < ApplicationController
  def call
    return redirect_if_is_not_authenticated if not_authenticated_and_html?

    invoice = Invoice.new
    render 'invoices/new', locals: { invoice: }
  end
end
