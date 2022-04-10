class User::Register::SendMail < Micro::Case
  attribute :user
  attribute :mailer, default: ->(value) { value || UserMailer }
  validates :user, kind: User
  def call!
    mailer.with(user: user).send_token.deliver_later
    Success result: { user: }
  end
end
