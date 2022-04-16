class Invoice::Create::GeneratePdf < Micro::Case
  attribute :invoice
  def call!
    generate_pdf
    Success result: { invoice: }
  rescue => e
      Failure :pdf_error, result: { message: e.message }
  end

  private

  def generate_pdf
    pdf = ::Prawn::Document.new
    pdf.text "Invoice: ##{invoice.invoice_number}"
    pdf.text "Date: #{invoice.invoice_date&.strftime('%a, %-d %b %Y')}"
    pdf.text "From: #{invoice.customer_name}"
    pdf.text "Notes: #{invoice.customer_notes}"
    pdf.text "Total: #{invoice.total_amount_due}"
    string_pdf = pdf.render
    io = StringIO.new string_pdf
    invoice.documents.attach(io:, filename: "invoice-#{invoice.id}-#{SecureRandom.uuid}.pdf")
  end
end
