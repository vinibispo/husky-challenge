require 'swagger_helper'

RSpec.describe 'api/v1/invoices/create', type: :request do
  path '/api/v1/invoices' do
    post('call create') do
      tags "Invoices"
      consumes "application/json"
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          invoice: { type: :object, properties: {

            invoice_number: { type: :integer },
            invoice_date: { type: :string },
            customer_name: { type: :string },
            customer_name: { type: :string },
            total_amount_due: { type: :integer },
            emails: { type: :string }
          } }
        },
        required: ['emails']
      }
      response(200, 'successful') do
        let(:params) { { invoice: { emails: "vini@husky.io,vini@google.com" } } }

        let(:user) { create(:user) }
        let(:user_token)  { create(:user_token, user:, confirmed_at: DateTime.now) }
        security [Bearer: []]

        let(:Authorization) { "Bearer #{user_token.token}" }

        # after do |example|
        #   example.metadata[:response][:content] = {
        #     'application/json' => {
        #       example: JSON.parse(response.body, symbolize_names: true)
        #     }
        #   }
        # end
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:params) { { invoice: { emails: "" } } }

        let(:user) { create(:user) }
        let(:user_token)  { create(:user_token, user:, confirmed_at: DateTime.now) }
        security [Bearer: []]

        let(:Authorization) { "Bearer #{user_token.token}" }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:params) { { invoice: { emails: "vini@husky.io,vini@google.com" } } }
        security [Bearer: []]

        let(:Authorization) { "Bearer t" }
        run_test!
      end
    end
  end
end
