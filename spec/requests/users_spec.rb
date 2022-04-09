require 'rails_helper'
RSpec.describe '/users' do
  describe 'POST /create' do
    it 'should return success' do
      user_attributes = attributes_for(:user)

      post users_path, params: { user: user_attributes }
    end
  end
end
