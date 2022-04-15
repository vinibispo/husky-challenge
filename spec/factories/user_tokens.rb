FactoryBot.define do
  factory :user_token do
    token { "" }
    confirmed_at { nil }
  end
end
