require 'rails_helper'

RSpec.describe UserToken, type: :model do
  subject { build(:user_token) }
  it { should have_secure_token }
end
