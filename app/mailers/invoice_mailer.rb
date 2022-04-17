# mailer for invoice
class InvoiceMailer < ApplicationMailer
  def created
    invoice = params[:invoice]

    emails = invoice.emails.split(',')

    attachments["invoice-#{invoice.id}-#{SecureRandom.uuid}.pdf"] = { mime_type: 'application/pdf', content: invoice.documents.last.blob.download }
    mail(to: emails, subject: "Invoice #{invoice.id} from #{invoice.customer_name}") do |format|
      format.html { render 'invoice_mailer/created', locals: { invoice: } }
    end
  end
end
