class Invoice < ApplicationRecord
  belongs_to :user, default: -> { Current.user }, inverse_of: :invoices
  has_many_atttached :documents
  after_save do
    InvoiceMailer.with(invoice: self).created.deliver_now
  end
end
