# frozen_string_literal: true

# create controller for invoices
class Invoices::CreateController < ApplicationController
  def call
    return redirect_if_is_not_authenticated if not_authenticated_and_html?

    @invoice = Invoice.new(Invoice::Params.to_save(params))
    respond_to do |format|
      which_screen_should_render(format)
    end
  end

  private

  def which_screen_should_render(format)
    if @invoice.save
      format.html { redirect_to invoice_url(@invoice), notice: I18n.t("flash.invoices.create.success") }
      format.json { render 'invoices/show', status: :created, location: @invoice }
    else
      format.html { render 'invoices/new', status: :unprocessable_entity }
      format.json { render json: @invoice.errors, status: :unprocessable_entity }
    end
  end
end
