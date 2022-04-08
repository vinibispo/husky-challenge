require 'rails_helper'

RSpec.describe 'Invoices', type: :system do
  it 'shows unauthorized when has no access' do
    visit '/invoices'

    expect(page).to have_content flash('user.unauthorized')
  end

  it 'shows invoices when user is authenticated' do
    token = '123456'

    sign_in_as(token)
    visit '/invoices'

    expect(page).to have_content 'Invoices'
    expect(page).to have_content button('invoices.new')
  end

  it 'creates an invoice when user is authenticated' do
    token = '123456'
    count_before = Invoice.count

    sign_in_as(token)
    visit '/invoices'

    click_on button('invoices.new')

    invoice = build(:invoice)
    fill_in field('invoices.invoice_number'), with: invoice.invoice_number
    fill_in field('invoices.invoice_date'), with: invoice.invoice_date
    fill_in field('invoices.total_amount_due'), with: invoice.total_amount_due
    fill_in field('invoices.emails'), with: invoice.emails

    click_on button('invoices.create')

    expect(Invoice.count - count_before).to eq(1)
    expect(page).to have_content(flash('invoices.create.success'))
  end

  it 'creates an invoice when user is authenticated and go to the url of new' do
    token = '123456'
    count_before = Invoice.count

    sign_in_as(token)
    visit '/invoices/new'

    invoice = build(:invoice)

    fill_in field('invoices.invoice_number'), with: invoice.invoice_number
    fill_in field('invoices.invoice_date'), with: invoice.invoice_date
    fill_in field('invoices.total_amount_due'), with: invoice.total_amount_due
    fill_in field('invoices.emails'), with: invoice.emails

    click_on button('invoices.create')

    expect(Invoice.count - count_before).to eq(1)
    expect(page).to have_content(flash('invoices.create.success'))
  end

  it 'updates an invoice when user is authenticated and get to route edit' do
    token = '123456'
    invoice = create(:invoice)

    sign_in_as(token)

    visit "/invoices/#{invoice.id}/edit"

    fill_in field('invoices.invoice_number'), with: "#{invoice.invoice_number}1"

    click_on button('invoices.update')

    expect(page).to have_content(flash('invoices.update.success'))
  end

  it 'destroys an invoice when user is authenticated and get to route show' do
    token = '123456'
    invoice = create(:invoice)

    sign_in_as(token)
    visit "/invoices/#{invoice.id}"

    click_on button('invoices.destroy')

    expect(page).to have_content(flash('invoices.destroy.success'))
  end

  it 'logout when user is authenticated' do
    token = '123456'

    sign_in_as(token)

    click_on button('sign_out')

    expect(page).to have_current_path(root_path)
  end
end
