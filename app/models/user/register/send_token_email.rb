# send token email for register for user
class User::Register::SendTokenEmail < Micro::Case
  attribute :user
  attribute :token
  attribute :mailer, default: ->(value) { value || UserMailer }
  validates :user, kind: User
  validates :token, kind: String
  def call!
    mailer.with(user:, token:).send_token.deliver_later
    Success result: { user:, message: I18n.t("flash.users.create.success") }
  end
end
