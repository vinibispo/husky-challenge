# flow for show for invoices
class Invoice::Show::Flow < Micro::Case
  attribute :id
  attribute :token
  validates :id, kind: { of: [String, Numeric] }

  AuthenticationFlow = Micro::Cases.flow([Invoice::GetToken, Invoice::GetAuthentication])
  private_constant :AuthenticationFlow

  def call!
    AuthenticationFlow
      .call(token:)
    invoice = Invoice.find(id)
    Success result: { invoice: }
  rescue ActiveRecord::RecordNotFound => e
    Failure :not_found, result: { message: e.message }
  end
end
