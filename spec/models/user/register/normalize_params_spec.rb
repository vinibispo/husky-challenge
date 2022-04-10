require 'rails_helper'
RSpec.describe User::Register::NormalizeParams do
  it 'should return failure when has email blank' do
    params = ActionController::Parameters.new({ user: { email: '' } })

    result = User::Register::NormalizeParams.call(params:)

    expect(result.failure?).to be true
  end
end
