require 'rails_helper'
RSpec.describe User::Register::Flow do
  it 'should get user params and return user created' do
    params = ActionController::Parameters.new({ user: { email: 'johndoe@husky.io' }})

    result = described_class.call(params:)

    user = User.last
    expected = { user: }

    expect(result.success?).to be true
    expect(result.data).to eq(expected)
  end
end
