class Session::Create::GetToken < Micro::Case
  attribute :session
  validates :session, kind: Session
  def call!
    return Failure :invalid, result: { session: } if session.invalid?

    user_token = UserToken.not_revoked.confirmed.find_by(token: session.token)
    return Failure :no_token, result: { session:, message: I18n.t('get_token.error', scope: 'flash.sessions.create') } if user_token.blank?

    Success result: { user_token: }
  end
end
