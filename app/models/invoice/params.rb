# frozen_string_literal: true

# params for invoice
module Invoice::Params
  def self.to_save(params)
    params.require(:invoice).permit(:invoice_number, :invoice_date, :customer_name, :customer_notes,
                                    :total_amount_due, :emails)
  end
end
