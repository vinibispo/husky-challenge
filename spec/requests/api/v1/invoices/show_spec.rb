require 'swagger_helper'

RSpec.describe 'api/v1/invoices/show', type: :request do

  path '/api/v1/invoices/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('call show') do
      tags "Invoices"
      response(404, 'not found') do
        let(:id) { '123' }
        let(:user) { create(:user) }
        let(:user_token) { create(:user_token, user:, confirmed_at: DateTime.now) }

        security [Bearer: []]

        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end
      response(401, 'unauthorized') do
        let(:user) { create(:user) }
        let(:id) { '123' }
        
        security [Bearer: []]

        let(:Authorization) { "Bearer t" }

        run_test!
      end

      response(200, 'success') do
        
        let(:user) { create(:user) }
        let(:user_token) { create(:user_token, confirmed_at: DateTime.now, user:) }
        let(:invoice) { create(:invoice, user:) }
          let(:id) { invoice.id }

        security [Bearer: []]

        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end
    end
  end
end
