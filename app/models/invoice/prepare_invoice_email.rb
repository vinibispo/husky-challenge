# prepare invoice email for invoice
class Invoice::PrepareInvoiceEmail < Micro::Case
  attribute :invoice
  def call!
    emails = invoice.emails.split(',')
    return Failure :no_emails, result: { message: "There is no email for sending" } if emails.count.zero?

    documents = invoice.documents
    return Failure :no_pdf, result: { message: "There is no pdf" } if documents.count.zero?

    content = documents.last.blob.download
    attachment = { mimetype: 'application/pdf', content: }

    Success result: { emails:, attachment: }
  end
end
