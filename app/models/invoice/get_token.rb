# get_token module for invoice
class Invoice::GetToken < Micro::Case
  attribute :token
  validates :token, kind: String
  def call!
    return Failure :blank_token, result: { message: I18n.t('flash.invoices.get_token.error') } if token.blank?

    Success result: { token: }
  end
end
