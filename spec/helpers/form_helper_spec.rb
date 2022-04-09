require 'rails_helper'
RSpec.describe FormHelper, type: :helper do
  describe "#create_or_update" do
    it 'should return create when object#persisted? returns false' do
      invoice = Invoice.new
      result = helper.create_or_update(invoice)
      expected = 'create'
      expect(result).to eq(expected)
    end

    it 'should return update when object#persisted? returns true' do
      invoice = create(:invoice)
      result = helper.create_or_update(invoice)
      expected = 'update'
      expect(result).to eq(expected)
    end
  end
end
