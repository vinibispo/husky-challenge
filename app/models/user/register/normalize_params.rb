# normailze_params for register for user
class User::Register::NormalizeParams < Micro::Case
  attribute :params
  validates :params, kind: ActionController::Parameters

  ValidateEmail = ->(email) { email =~ URI::MailTo::EMAIL_REGEXP }

  def call!
    return Failure :blank_email, result: { message: I18n.t('email.blank', scope: 'activerecord.errors.models.user.attributes') } if user_params[:email].blank?
  end

  private

  def user_params
    ::User::Params.to_save(params)
  end
end
