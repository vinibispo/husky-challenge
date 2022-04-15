require 'rails_helper'
RSpec.describe UserToken::Activate do
  it 'should activate' do
    user = create(:user)
    user_token = create(:user_token, user:)

    result = UserToken::Activate.call(user:, user_token:)

    expected_result = { user:, user_token: }

    expect(result.success?).to be true

    expect(result.data).to eq(expected_result)
  end
end
