FactoryBot.define do
  factory :invoice do
    invoice_number { '123456' }
    invoice_date { Time.zone.now }
    total_amount_due { 8_000 }
    customer_name { 'John Doe' }
    customer_notes { 'Observation' }
    emails { 'johndoe@husky.io,johndoe@google.com' }
  end
end
