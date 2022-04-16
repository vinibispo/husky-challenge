class User < ApplicationRecord
  has_many :user_tokens, inverse_of: :user, dependent: :destroy
  has_many :invoices, inverse_of: :user

  validates :email, presence: true, uniqueness: true
end
