class Invoice::SendEmails::SendInvoiceEmail < Micro::Case
  attribute :invoice
  attribute :emails
  attribute :mailer, default: ->(value) { value || InvoiceMailer }

  validates :invoice, kind: Invoice
  validates :emails, kind: Array

  def call!
    mailer.with(emails:, invoice:).new_email.deliver_later
    Success result: { invoice: }
  end
end
