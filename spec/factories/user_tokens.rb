FactoryBot.define do
  factory :user_token do
    token { "" }
    revoked_at { "2022-04-12 08:02:20" }
    confirmed_at { "2022-04-12 08:02:20" }
  end
end
