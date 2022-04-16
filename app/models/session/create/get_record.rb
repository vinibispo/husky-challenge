class Session::Create::GetRecord < Micro::Case
  attribute :user_token
  validates :user_token, kind: UserToken

  def call!
    user = user_token.user
    session = Session.new(token: user_token.token) #add just for retrieving new page
    return Failure :no_user, result: { message: I18n.t('get_record.error', scope: 'sessions.create'), session: } if user.blank?

    Success result: { user: user }
  end
end
