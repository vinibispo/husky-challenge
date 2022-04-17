# new object step for new for invoice
class Invoice::New::NewObject < Micro::Case
  attribute :user
  validates :user, kind: User

  def call!
    invoice = user.invoices.new
    Success result: { invoice: }
  end
end
