class User::Register::Create < Micro::Case
  attribute :user
  attribute :email
  validates :user, kind: { of: [User, NilClass] }
  validates :email, kind: String
  def call!
    return Success result: { user: } if user.present?

    new_user = User.new(email:)

    return Success result: { user: new_user } if new_user.save

    Failure :invalid_email, result: { errors: new_user.errors }
  end
end
