require 'rails_helper'
RSpec.describe '/users' do
  describe 'POST /create' do
    it 'should return success' do
      user_attributes = attributes_for(:user)

      post users_path, params: { user: user_attributes }

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response.body).to include(flash('users.create.success'))
    end

    describe 'when has errors' do
      it 'should redirect to current_page when has no key user' do
        post users_path, params: { hello: "world" }

        expect(response).to redirect_to(register_users_path)

        follow_redirect!

        expected = 'param is missing or the value is empty: user'

        expect(response.body).to include(expected)
      end

      it 'should redirect to current_page when has blank email' do
        post users_path, params: { user: { email: '' } }

        expect(response).to redirect_to(register_users_path)

        follow_redirect!

        expected = 'blank'

        expect(response.body).to include(expected)
      end

      it 'should redirect to current_page when has invalid email' do
        post users_path, params: { user: { email: 'invalid-email' } }

        expect(response).to redirect_to(register_users_path)

        follow_redirect!

        expected = 'invalid'

      expect(response.body).to include(expected)
      end
    end
  end
end
