# frozen_string_literal: true

# create controller for invoices
class Invoices::CreateController < ApplicationController
  def call
    return redirect_if_is_not_authenticated if not_authenticated_and_html?

    invoice = Invoice.new(Invoice::Params.to_save(params))
    respond_to do |format|
      which_screen_should_render(format, invoice)
    end
  end

  private

  def which_screen_should_render(format, invoice)
    if invoice.save
      format.html { redirect_to invoice_url(invoice), notice: I18n.t("flash.invoices.create.success") }
      format.json { render 'invoices/show', locals: { invoice: }, status: :created, location: invoice }
    else
      format.html { render 'invoices/new', locals: { invoice: }, status: :unprocessable_entity }
      format.json { render json: invoice.errors, status: :unprocessable_entity }
    end
  end
end
