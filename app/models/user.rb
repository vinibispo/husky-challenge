class User < ApplicationRecord
  has_many :user_tokens, inverse_of: :user, dependent: :destroy
  validates :email, presence: true, uniqueness: true
  has_secure_token
end
