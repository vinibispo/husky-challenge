class Invoice < ApplicationRecord
  validates :emails, presence: true
  belongs_to :user, default: -> { Current.user }, inverse_of: :invoices
  has_many_attached :documents
end
