require 'rails_helper'
RSpec.describe User::Register::CreateRecord do
  it 'should create a user when there is no user' do
    user = nil
    email = 'johndoe@husky.io'

    result = User::Register::CreateRecord.call(user:, email:)

    user = User.last
    expected = { user: }

    expect(result.success?).to be true
    expect(result.data).to eq(expected)
  end

  it 'should do nothing when there is user' do
    email = 'johndoe@husky.io'
    user = create(:user, email:)

    result = User::Register::CreateRecord.call(user:, email:)

    expected = { user: }

    expect(result.success?).to be true
    expect(result.data).to eq(expected)
  end
end
