require 'rails_helper'
RSpec.describe User::Register::NormalizeParams do
  it 'should return failure when has email blank' do
    params = ActionController::Parameters.new({ user: { email: '' } })

    result = User::Register::NormalizeParams.call(params:)

    expected = I18n.t('email.blank', scope: 'activerecord.errors.models.user.attributes')

    expect(result.failure?).to be true
    expect(result[:message]).to eq(expected)
  end

  it 'should return failure when has invalid email' do
    params = ActionController::Parameters.new({ user: { email: 'invalid-email' } })

    result = User::Register::NormalizeParams.call(params:)

    expected = I18n.t('email.invalid', scope: 'activerecord.errors.models.user.attributes')

    expect(result.failure?).to be true
    expect(result[:message]).to eq(expected)
  end

  it 'should return success when has valid email' do
    params = ActionController::Parameters.new({ user: { email: 'johndoe@husky.io' } })

    result = User::Register::NormalizeParams.call(params:)

    expected = 'johndoe@husky.io'

    expect(result.success?).to be true
    expect(result[:email]).to eq(expected)
  end

  it 'should return failure when has no user key in params' do
    params = ActionController::Parameters.new({ email: 'johndoe@husky.io' })

    result = User::Register::NormalizeParams.call(params:)

    expected = 'param is missing or the value is empty: user'

    expect(result.failure?).to be true
    expect(result[:message]).to eq(expected)
  end
end
