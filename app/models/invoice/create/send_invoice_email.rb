# send invoice email step for create for invoice
class Invoice::Create::SendInvoiceEmail < Micro::Case
  attribute :invoice
  attribute :mailer, default: ->(value) { value || InvoiceMailer }
  validates :invoice, kind: Invoice
  def call!
    mailer.with(invoice:).created.deliver_later
    Success result: { invoice:, message: I18n.t('flash.invoices.create.success') }
  end
end
