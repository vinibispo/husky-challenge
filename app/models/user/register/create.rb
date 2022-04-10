class User::Register::Create < Micro::Case
  attribute :user
  validates :user, kind: User
  def call!
  end
end
