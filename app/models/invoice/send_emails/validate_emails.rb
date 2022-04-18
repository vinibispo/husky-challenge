class Invoice::SendEmails::ValidateEmails < Micro::Case
  attribute :params
  attribute :invoice
  validates :params, kind: ActionController::Parameters
  validates :invoice, kind: Invoice

  ValidateEmail = ->(email) { email =~ URI::MailTo::EMAIL_REGEXP }

  private_constant :ValidateEmail
  def call!
    emails = invoice_params[:emails].split(',')
    return Failure :no_emails, result: { message: I18n.t('email.invalid', scope: 'activerecord.errors.models.user.attributes') } if emails.count.zero?

    valid_emails = emails.select(&ValidateEmail)
    return Failure :no_valid_emails, result: { message: I18n.t('email.invalid', scope: 'activerecord.errors.models.user.attributes') } if valid_emails.count.zero?

    Success result: { emails: valid_emails, invoice: }
  end

  private

  def invoice_params
    ::Invoice::Params.to_save(params)
  end
end
