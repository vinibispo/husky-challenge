class Invoice::Create::CreateRecord < Micro::Case
  attribute :user
  attribute :params
  validates :user, kind: User
  validates :params, kind: ActionController::Parameters

  def call!
    invoice = user.invoices.new(invoice_params)
    if invoice.save
      return Success result: { invoice: }
    end

    Failure :invoice_error, result: { invoice: }
  end

  private
  def invoice_params
    ::Invoice::Params.to_save(params)
  end
end
