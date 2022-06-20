FactoryBot.define do
  factory :booking do
    participants { 3 }
    date { Date.tomorrow }
    status { 0 }
    user
    experience
  end
end
