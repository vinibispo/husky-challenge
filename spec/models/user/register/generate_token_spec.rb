require 'rails_helper'
RSpec.describe User::Register::GenerateToken do

  it 'should regenerate token when there is user' do
    email = 'johndoe@husky.io'
    user = create(:user, email:)

    result = User::Register::GenerateToken.call(user:)

    user.reload
    expected = { user:}

    expect(result.success?).to be true
    expect(result.data).to eq(expected)
  end
end
