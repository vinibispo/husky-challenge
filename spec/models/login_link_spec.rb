require 'rails_helper'
RSpec.describe LoginLink do
  it 'should be a valid link' do
    user = create(:user)
    user_token = create(:user_token, user:)

    link = LoginLink.create!(email: user.email, token: user_token.token)

    result = LoginLink.valid?(link)

    expect(result).to be true
  end

  it 'should be a invalid link when token is revoked' do
    user = create(:user)
    user_token = create(:user_token, revoked_at: DateTime.now, user:)

    link = LoginLink.create!(email: user.email, token: user_token.token)

    result = LoginLink.valid?(link)

    expect(result).to be false
  end
end
