FactoryBot.define do
  factory :article do
    title { Faker::Lorem.characters(number: 5) }
    text { Faker::Lorem.characters(number: 50) }
    user
  end
end
