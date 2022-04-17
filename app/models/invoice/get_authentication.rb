# get_authentication module for invoice
class Invoice::GetAuthentication < Micro::Case
  attribute :token
  validates :token, kind: String
  def call!
    user_token = UserToken.confirmed.not_revoked.find_by(token:)
    return Failure :no_token, result: { message: I18n.t('flash.invoices.get_authentication.error') } if user_token.blank?

    user = user_token.user
    return Failure :no_user, result: { message: I18n.t('flash.invoices.get_authentication.error') } if user.blank?

    Current.user = user

    Success result: { user: }
  end
end
