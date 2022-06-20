FactoryBot.define do
  factory :experience do
    name { "Walk around Shibuya" }
    description { "See the sights of Shibuya street life" }
    price { 500 }
    address { "123 Shibuya" }
    latitude { 35.6620 }
    longitude { 139.7038 }
    start_time { Time.parse('9:00am') }
    end_time { Time.parse('11:00am') }
    status { 'active' }
    user
  end
end
