class UserToken::Activate < Micro::Case
  attribute :user
  attribute :user_token

  validates :user, kind: User
  validates :user_token, kind: UserToken

  def call!
    user_token.activate!
    Success result: { user:, user_token: }
  end
end
