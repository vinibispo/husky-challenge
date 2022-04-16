# destroy controller for invoice
class Invoices::DestroyController < ApplicationController
  def call
    return redirect_if_is_not_authenticated if not_authenticated_and_html?

    invoice = Invoice.find(params[:id])
    invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, success: I18n.t("flash.invoices.destroy.success") }
      format.json { head :no_content }
    end
  end
end
