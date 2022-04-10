require 'rails_helper'
RSpec.describe User::Register::SendMail do
  it 'should send email' do
    user = create(:user)

    result = User::Register::SendMail.call(user:)

    expected = { user: }

    expect(result.success?).to be true
    expect(result.data).to eq(expected)
  end
end

