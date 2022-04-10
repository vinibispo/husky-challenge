require 'rails_helper'
RSpec.describe User::Register::SendMail do
  it 'should send email' do
    user = create(:user)

    result = User::Register::SendMail.call(user:)
  end
end

