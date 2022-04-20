# get record implementation for show for invoices verifying if is authorized
class Invoice::Show::Authorized::GetRecord < Micro::Case
  attribute :user
  attribute :id

  validates :user, kind: User
  validates :id, kind: { of: [Numeric, String] }

  def call!
    invoice = user.invoices.find(id)
    Success result: { invoice: }
  rescue ActiveRecord::RecordNotFound
    Failure :not_found
  end
end
