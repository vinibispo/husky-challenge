class User::Register::SendMail < Micro::Case
  attribute :user
  attribute :mailer, default: ->(value) { value || UserMailer }
  def call!
    mailer.with(user: user).send_token.deliver_later
  end
end
