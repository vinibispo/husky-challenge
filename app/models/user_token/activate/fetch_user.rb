# fetch user for activate user_token
class UserToken::Activate::FetchUser < Micro::Case
  attribute :user_token
  validates :user_token, kind: UserToken

  def call!
    user = user_token.user
    return Failure :no_user, result: { message: I18n.t('flash.user_tokens.activate.fetch_user.error') } if user.blank?

    Success result: { user:, user_token: }
  end
end
