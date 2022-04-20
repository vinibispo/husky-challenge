require 'swagger_helper'

RSpec.describe 'api/v1/invoices/index', type: :request do
  path '/api/v1/invoices' do
    get('call index') do
      tags "Invoices"
      consumes "application/json"
      response(401, 'unauthorized') do
        security [Bearer: []]
        let(:Authorization) { "Bearer" }
        run_test!
      end

      response(401, 'unauthorized when has no valid token') do
        security [Bearer: []]
        let(:Authorization) { "Bearer t" }
        run_test!
      end

      response(200, 'fetch invoices') do
        let(:user) { create(:user) }
        let(:user_token) { create(:user_token, user:, confirmed_at: DateTime.now) }
        let(:invoice) { create(:invoice) }
        security [Bearer: []]

        let(:Authorization) { "Bearer #{user_token.token}" }
        schema type: :array, items: {
          type: :object, properties: {
            id: { type: :integer },
            invoice_number: { type: :string },
            invoice_date: { type: :string },
            customer_notes: { type: :string },
            total_amount_due: { type: :float },
            emails: { type: :string },
            created_at: { type: :string },
            updated_at: { type: :sting }
          }
        }
        run_test!
      end
    end
  end
end
