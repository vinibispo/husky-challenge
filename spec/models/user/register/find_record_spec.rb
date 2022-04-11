require 'rails_helper'
RSpec.describe User::Register::FindRecord do
  it 'should return success when there is no user' do
    email = 'johndoe@husky.io'

    result = User::Register::FindRecord.call(email:)

    expected = { user: nil, email: 'johndoe@husky.io' }

    expect(result.success?).to be true
    expect(result.data).to eq(expected)
  end

  it 'should return success where there is user' do
    email = 'johndoe@husky.io'
    user = create(:user, email:)

    result = User::Register::FindRecord.call(email:)

    expected = { user:, email: }

    expect(result.success?).to be true
    expect(result.data).to eq(expected)
  end
end
