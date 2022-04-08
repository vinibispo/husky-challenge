require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/invoices", type: :request do

  # This should return the minimal set of attributes required to create a valid
  # Invoice. As you add validations to Invoice, be sure to
  # adjust the attributes here as well.

  before { post tokens_url, params: { token: '123456' } }

  describe "JSON" do

    let(:valid_attributes) {
      { emails: 'email@example.com,johndoe@husky.io' }
    }

    let(:invalid_attributes) {
      skip("Add a hash of attributes invalid for your model")
    }

    describe "GET /index" do
      it "renders a successful response" do
        count_before = Invoice.count
        get "#{invoices_url}.json"

        expect(response).to be_successful

        parsed_body = JSON.parse(body)
        expect(count_before).to eq(parsed_body.count)
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        invoice = Invoice.create! valid_attributes
        get "#{invoice_url(invoice)}.json"
        expect(response).to be_successful
        parsed_body = JSON.parse(body)
        expect(invoice.id).to eq(parsed_body["id"])
      end
    end

    describe "POST /create" do
      it "renders a successful response" do
        attrs = attributes_for(:invoice)

        post "#{invoices_url}.json", params: { invoice: attrs }
        parsed_body = JSON.parse(body)

        expect(response).to be_successful

        expect(parsed_body["id"]).to_not be_nil
        expect(parsed_body["name"]).to eq(attrs[:name])

      end
    end

    describe "PUT /update" do
      it "renders a successful response" do
        invoice = Invoice.create! valid_attributes

        attributes = attributes_for(:invoice)

        put "#{invoice_url(invoice)}.json", params: { invoice: attributes }

        parsed_body = JSON.parse(body)

        expect(response).to be_successful
        expect(parsed_body["id"]).to eq(invoice.id)
        expect(parsed_body["name"]).to eq(attributes[:name])

      end
    end

    describe "DELETE /destroy" do
      it 'renders a successful response' do
        invoice = Invoice.create! valid_attributes

        delete "#{invoice_url(invoice)}.json"

        expect(response).to be_successful
      end
    end
  end
end
