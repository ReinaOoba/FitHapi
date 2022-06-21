FactoryBot.define do
  factory :article do
    name { Faker::Lorem.characters(number: 5) }
  end
end