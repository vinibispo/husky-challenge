class UserToken::Activate::FetchRecord < Micro::Case
  attribute :token
  validates :token, kind: String
  def call!()
    user_token = UserToken.includes(:user).not_confirmed_and_not_revoked.find_by(token: token)
    return Failure :invalid_token, result: { message: "There is no token for this user" } if user_token.blank?

    Success result: { user_token: }
  end
end
