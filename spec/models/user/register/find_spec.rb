require 'rails_helper'
RSpec.describe User::Register::Find do
  it 'should return success when there is no user' do
    email = 'johndoe@husky.io'

    result = User::Register::Find.call(email:)

    expected = { user: nil, email: 'johndoe@husky.io' }

    expect(result.success?).to be true
    expect(result.data).to eq(expected)

  end
end
