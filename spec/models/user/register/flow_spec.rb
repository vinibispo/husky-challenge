require 'rails_helper'
RSpec.describe User::Register::Flow do
  it 'should get user params and return user created' do
    params = ActionController::Parameters.new({ user: { email: 'johndoe@husky.io' } })

    result = User::Register::Flow.call(params:)

    user = User.last
    expected = { user: }

    expect(result.success?).to be true
    expect(result.data).to eq(expected)
  end

  it 'should get user params when user exists and just regenerate token' do
    email = 'johndoe@husky.io'
    user = create(:user)
    params = ActionController::Parameters.new({ user: { email: } })

    result = User::Register::Flow.call(params:)

    user.reload
    expected = { user: }

    expect(result.success?).to be true
    expect(result.data).to eq(expected)
  end
end
