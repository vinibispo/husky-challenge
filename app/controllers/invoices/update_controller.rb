# update controller for invoices
class Invoices::UpdateController < ApplicationController
  def call
    return redirect_if_is_not_authenticated if not_authenticated_and_html?

    @invoice = Invoice.find(params[:id])

    respond_to do |format|
      which_screen_should_render(format)
    end
  end

  private

  def which_screen_should_render(format)
    if @invoice.update(Invoice::Params.to_save(params))
      format.html { redirect_to invoice_url(@invoice), notice: I18n.t("flash.invoices.update.success") }
      format.json { render 'invoices/show', status: :ok, location: @invoice }
    else
      format.html { render 'invoices/edit', status: :unprocessable_entity }
      format.json { render json: @invoice.errors, status: :unprocessable_entity }
    end
  end
end
