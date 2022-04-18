# mailer for invoice
class InvoiceMailer < ApplicationMailer
  def created
    Invoice::PrepareInvoiceEmail
      .call(invoice: params[:invoice])
      .on_failure { |result| logger(result) }
      .on_success { |result| render_email(result) }
  end

  def new_email
    Invoice::PrepareInvoiceEmail
      .call(invoice: params[:invoice])
      .on_failure { |result| logger(result) }
      .on_success do |_result|
      emails = params[:emails]
      invoice = params[:invoice]
      mail(to: emails, subject: "Invoice #{invoice.id} from #{invoice.customer_name}") do |format|
        format.html { render 'invoice_mailer/created', locals: { invoice: } }
      end
    end
  end

  private

  def render_email(result)
    invoice = params[:invoice]
    attachments["invoice-#{invoice.id}-#{SecureRandom.uuid}.pdf"] = result[:attachment]
    emails = result[:emails]

    mail(to: emails, subject: "Invoice #{invoice.id} from #{invoice.customer_name}") do |format|
      format.html { render 'invoice_mailer/created', locals: { invoice: } }
    end
  end

  def logger(result)
    Rails.logger.warn "#{result} invoice_mailer#created"
  end
end
