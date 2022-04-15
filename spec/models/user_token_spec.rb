require 'rails_helper'

RSpec.describe UserToken, type: :model do
  subject { build(:user_token) }
  it { should have_secure_token }
  it 'should activate' do
    user = create(:user)
    user_token = create(:user_token, confirmed_at: nil, user: )

    user_token.activate!

    user_token.reload

    expect(user_token.confirmed_at).to_not be nil
  end
end
