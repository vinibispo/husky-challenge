# find for register for user
class User::Register::Find < Micro::Case
  attribute :email
  def call!
    user = User.find_by(email:)

    Success result: { user:, email: }
  end
end
