require 'rails_helper'

RSpec.describe 'Invoices', type: :system do
  it 'shows unauthorized when has no access' do
    visit '/invoices'

    expect(page).to have_content 'Acesso não autorizado!'
  end

  it 'shows invoices when user is authenticated' do
    token = '123456'

    sign_in_as(token)
    visit '/invoices'

    expect(page).to have_content 'Invoices'
    expect(page).to have_content 'New invoice'
  end

  it 'creates an invoice when user is authenticated' do
    token = '123456'
    count_before = Invoice.count

    sign_in_as(token)
    visit '/invoices'

    click_on 'New invoice'

    invoice = build(:invoice)
    fill_in 'Invoice number', with: invoice.invoice_number
    fill_in 'Invoice date', with: invoice.invoice_date
    fill_in 'Total amount due', with: invoice.total_amount_due
    fill_in 'Emails', with: invoice.emails

    click_on 'Create Invoice'

    expect(Invoice.count - count_before).to eq(1)
    expect(page).to have_content("Invoice was successfully created.")
  end

  it 'creates an invoice when user is authenticated and go to the url of new' do
    token = '123456'
    count_before = Invoice.count

    sign_in_as(token)
    visit '/invoices/new'

    invoice = build(:invoice)
    fill_in 'Invoice number', with: invoice.invoice_number
    fill_in 'Invoice date', with: invoice.invoice_date
    fill_in 'Total amount due', with: invoice.total_amount_due
    fill_in 'Emails', with: invoice.emails

    click_on 'Create Invoice'

    expect(Invoice.count - count_before).to eq(1)
    expect(page).to have_content("Invoice was successfully created.")
  end

  it 'updates an invoice when user is authenticated and get to route edit' do
    token = '123456'
    invoice = create(:invoice)

    sign_in_as(token)
    visit "/invoices/#{invoice.id}/edit"

    fill_in 'Invoice number', with: "#{invoice.invoice_number}1"

    click_on 'Update Invoice'

    expect(page).to have_content("Invoice was successfully updated.")
  end

  it 'updates an invoice when user is authenticated' do
    token = '123456'
    invoice = create(:invoice)

    sign_in_as(token)

    visit '/invoices'

    all('#invoices>p>a').last.click
    expect(page).to have_content('Edit this invoice')
    click_on 'Edit this invoice'

    fill_in 'Invoice number', with: "#{invoice.invoice_number}1"

    click_on 'Update Invoice'

    expect(page).to have_content("Invoice was successfully updated.")
  end

  it 'destroys an invoice when user is authenticated and get to route show' do
    token = '123456'
    invoice = create(:invoice)

    sign_in_as(token)
    visit "/invoices/#{invoice.id}"

    click_on 'Destroy this invoice'

    expect(page).to have_content('Invoice was successfully destroyed.')
  end

  it 'destroys an invoice when user is authenticated' do
    token = '123456'
    create(:invoice)

    sign_in_as(token)

    all('#invoices>p>a').last.click
    click_on 'Destroy this invoice'

    expect(page).to have_content('Invoice was successfully destroyed.')
  end
end
