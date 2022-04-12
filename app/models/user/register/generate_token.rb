# regenerate token for register for user
class User::Register::GenerateToken < Micro::Case
  attribute :user

  validates :user, kind: User

  def call!
    user.user_tokens.create
    Success result: { user: }
  end
end
