require 'rails_helper'
RSpec.describe User::Params do
  it 'should raise ActionController::ParameterMissing when has no key user' do
    params = ActionController::Parameters.new({})

    result = -> { User::Params.to_save(params) }
    expected_error = ActionController::ParameterMissing

    expect { result.call }.to raise_error(expected_error)
  end
end
