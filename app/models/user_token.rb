# tokens for user
class UserToken < ApplicationRecord
  has_secure_token
  belongs_to :user
  scope :not_confirmed, -> { where(confirmed_at: nil) }
  scope :not_revoked, -> { where(revoked_at: nil) }
  scope :not_confirmed_and_not_revoked, -> { not_confirmed.not_revoked }
  scope :confirmed, -> { where.not(confirmed_at: nil) }

  def activate!
    update(confirmed_at: DateTime.now)
  end
end
