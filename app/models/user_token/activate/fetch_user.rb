class UserToken::Activate::FetchUser < Micro::Case
  attribute :user_token
  validates :user_token, kind: UserToken

  def call!
    user = user_token.user
    return Failure :no_user, result: { message: 'There is no user asssociated' } if user.blank?

    Success result: { user:, user_token: }
  end
end
