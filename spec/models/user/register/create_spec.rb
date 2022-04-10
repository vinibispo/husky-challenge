require 'rails_helper'
RSpec.describe User::Register::Create do
  it 'should create a user when there is no user' do
    user = nil
    email = 'johndoe@husky.io'

    result = User::Register::Create.call(user:, email:)

    user = User.last
    expected = { user: }

    expect(result.success?).to be true
    expect(result.data).to eq(expected)
  end
end
