require 'rails_helper'
RSpec.describe User::Register::RegenerateToken do
  it 'should do nothing when has no user' do
    user = nil
    email = 'johndoe@husky.io'
    result = User::Register::RegenerateToken.call(email:, user:)

    expected = { user:, email: }

    expect(result.success?).to be true
    expect(result.data).to eq(expected)
  end
end
