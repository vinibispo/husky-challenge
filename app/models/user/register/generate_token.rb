# regenerate token for register for user
class User::Register::GenerateToken < Micro::Case
  attribute :user

  validates :user, kind: User

  def call!
    user_token = user.user_tokens.create
    token = user_token.token
    Success result: { user:, token:  }
  end
end
