# list records step for fetch for invoice
class Invoice::Fetch::ListRecords < Micro::Case
  attribute :user
  validates :user, kind: User
  def call!
    invoices = user.invoices
    Success result: { invoices: }
  end
end
