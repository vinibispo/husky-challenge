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
  describe "Not authenticated" do
    describe "with expired token" do

      let(:valid_attributes) {
        { emails: 'email@example.com' }
      }
      before do
        user = create(:user)
        user_token = create(:user_token, user:, confirmed_at: DateTime.now)
        @user = user
        post sessions_url, params: { session: { token: user_token.token } }
        user_token.update(revoked_at: DateTime.now)
      end

      describe "GET /index" do
        it "does not render successful response" do
          @user.invoices.create! valid_attributes
          get invoices_url
          expect(response).to_not be_successful
        end
      end

      describe "POST /create" do

        it "should not succeed response" do
          post invoices_url, params: { invoice: valid_attributes }
          expect(response).to_not be_successful
        end
      end

      describe "GET /new" do
        it "does not render successful response" do
          get new_invoice_url
          expect(response).to_not be_successful
        end
      end

      describe "GET /show" do
        context "when has no record" do
          it "should have http status not_found" do
            get invoice_url(1)

            expect(response).to have_http_status :not_found
          end
        end
      end

      describe "PUT /send_emails" do
        it 'should not succeed response' do
          invoice = @user.invoices.create! valid_attributes
          put send_emails_invoice_url(invoice), params: { invoice: { emails: 'test@example.org,test@no-example.org' } }
          expect(response).to_not be_successful
        end
      end
    end

    describe "with no token" do
      let(:valid_attributes) {
        { emails: 'email@example.com' }
      }
      before do
        user = create(:user)
        create(:user_token, user:, confirmed_at: DateTime.now)
        @user = user
      end

      describe "POST /create" do
        it 'should not succeed response' do
          post invoices_url, params: { invoice: valid_attributes }
          expect(response).to_not be_successful
        end
      end

      describe "GET /new" do
        it 'should not succeed response' do
          get new_invoice_url
          expect(response).to_not be_successful
        end
      end
      describe "PUT /send_emails" do
        it 'should not succeed response' do
          invoice = @user.invoices.create! valid_attributes
          put send_emails_invoice_url(invoice), params: { invoice: { emails: 'test@example.org,test@no-example.org' } }
          expect(response).to_not be_successful
        end
      end
    end
  end
  describe "Authenticated" do

    let(:valid_attributes) {
      { emails: 'email@example.com' }
    }

    let(:invalid_attributes) {
      { emails: '' }
    }

    before do
      user = create(:user)
      user_token = create(:user_token, user:, confirmed_at: DateTime.now)
      @user = user
      post sessions_url, params: { session: { token: user_token.token } }
    end

    describe "GET /index" do
      it "renders a successful response" do
        @user.invoices.create! valid_attributes
        get invoices_url
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        invoice = @user.invoices.create! valid_attributes
        get invoice_url(invoice)
        expect(response).to be_successful
      end
    end

    describe "GET /new" do
      it "renders a successful response" do
        get new_invoice_url
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new Invoice" do
          expect {
            post invoices_url, params: { invoice: valid_attributes }
          }.to change(Invoice, :count).by(1)
        end

        it "redirects to the created invoice" do
          post invoices_url, params: { invoice: valid_attributes }
          expect(response).to redirect_to(invoice_url(Invoice.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Invoice" do
          expect {
            post invoices_url, params: { invoice: invalid_attributes }
          }.to change(Invoice, :count).by(0)
        end

        it "renders a successful response (i.e. to display the 'new' template)" do
          post invoices_url, params: { invoice: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end

    describe "PUT /send_emails" do
      it 'should not succeed response when emails are blank' do
        invoice = @user.invoices.create! valid_attributes

        put send_emails_invoice_url(invoice), params: { invoice: { emails: '' } }

        expect(response).to_not be_successful
      end

      it 'should not succeed when emails are not valid' do
        invoice = @user.invoices.create! valid_attributes

        put send_emails_invoice_url(invoice), params: { invoice: { emails: 'test' } }

        expect(response).to_not be_successful
      end

      it 'should not succeen when invoice is not valid' do
        put send_emails_invoice_url(1), params: { invoice: { emails: 'vini@google.com,test@google.com' } }

        expect(response).to_not be_successful
      end
    end

  end
end
