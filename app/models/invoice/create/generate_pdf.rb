# generate pdf step for create for invoice
class Invoice::Create::GeneratePdf < Micro::Case
  attribute :invoice
  validates :invoice, kind: Invoice
  def call!
    attach_pdf
    Success result: { invoice: }
  rescue StandardError => e
    Failure :pdf_error, result: { message: e.message }
  end

  private

  def attach_pdf
    pdf = create_pdf
    io = StringIO.new pdf.render
    invoice.documents.attach(io:, filename: "invoice-#{invoice.id}-#{SecureRandom.uuid}.pdf")
  end

  def create_pdf
    pdf = ::Prawn::Document.new
    pdf.text "Invoice: ##{invoice.invoice_number}"
    pdf.text "Date: #{invoice.invoice_date&.strftime('%a, %-d %b %Y')}"
    pdf.text "From: #{invoice.customer_name}"
    pdf.text "Notes: #{invoice.customer_notes}"
    pdf.text "Total: #{invoice.total_amount_due}"
    pdf
  end
end
