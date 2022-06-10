FactoryBot.define do
  factory :account do
    email "testuser@example.com"
    first_name "Billy"
    last_name "Scammer"
    password "123123"
    admin false
  end
end
