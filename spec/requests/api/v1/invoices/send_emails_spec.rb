require 'swagger_helper'

RSpec.describe 'api/v1/invoices/send_emails', type: :request do
  path '/api/v1/invoices/{id}/send_emails' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    parameter name: :params, in: :body, schema: {
      type: :object,
      properties: {
        invoice: { type: :object, properties: { emails: { type: :string } } }
      }
    }

    put('call send_email') do
      tags "Invoices"
      consumes "application/json"
      response(404, 'not_found') do
        let(:id) { '123' }
        let(:params) { { invoice: { emails: 'vini@husky.io,johndoe@husky.io' } } }
        let(:user) { create(:user) }
        let(:user_token) { create(:user_token, user:, confirmed_at: DateTime.now) }

        security [Bearer: []]
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:id) { '123' }
        let(:params) { {} }
        security [Bearer: []]
        let(:Authorization) { "Bearer t" }

        run_test!
      end

      response(422, 'unprocessable entity when has no emails') do
        let(:params) { { invoice: { emails: '' } } }
        let(:user) { create(:user) }
        let(:user_token) { create(:user_token, user:, confirmed_at: DateTime.now) }
        let(:invoice) { create(:invoice, user:) }
        let(:id) { invoice.id }

        security [Bearer: []]
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end
      response(422, 'unprocessable entity when has no valid emails') do
        let(:params) { { invoice: { emails: 'batata' } } }
        let(:user) { create(:user) }
        let(:user_token) { create(:user_token, user:, confirmed_at: DateTime.now) }
        let(:invoice) { create(:invoice, user:) }
        let(:id) { invoice.id }

        security [Bearer: []]
        let(:Authorization) { "Bearer #{user_token.token}" }
        run_test!
      end

      response(200, 'success') do
        let(:params) { { invoice: { emails: 'vini@husky.io' } } }
        let(:user) { create(:user) }
        let(:user_token) { create(:user_token, user:, confirmed_at: DateTime.now) }
        let(:invoice) { create(:invoice, user:) }
        let(:id) { invoice.id }
        security [Bearer: []]
        let(:Authorization) { "Bearer #{user_token.token}" }

        run_test!
      end
    end
  end
end
