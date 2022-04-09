require 'rails_helper'
RSpec.describe '/users' do
  describe 'POST /create' do
    it 'should return success' do
      user_attributes = attributes_for(:user)

      post "#{users_path}.json", params: { user: user_attributes }

      parsed_body = JSON.parse(response.body)

      expect(response).to be_successful
    end
  end
end
