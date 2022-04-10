class User::Register::RegenerateToken < Micro::Case
  attribute :email
  attribute :user

  validates :email, kind: String
  validates :user, kind: { of: [User, NilClass] }

  def call!
    user.regenerate_token if user.present?
    Success result: {email:, user:}
  end
end
