require 'rails_helper'
RSpec.describe User::Register::SendTokenEmail do
  it 'should send email' do
    user = create(:user)
    token = create(:user_token, user:).token

    result = User::Register::SendTokenEmail.call(user:, token:)

    message = I18n.t("flash.users.create.success")
    expected = { user:, message: }

    expect(result.success?).to be true
    expect(result.data).to eq(expected)
  end
end
