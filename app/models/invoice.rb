class Invoice < ApplicationRecord
  belongs_to :user, default: -> { Current.user }, inverse_of: :invoices
  after_save do
    InvoiceMailer.with(invoice: self).created.deliver_now
  end
end
