FactoryBot.define do
  factory :my_training do
    menu { Faker::Lorem.characters(number: 5) }
    set { Faker::Lorem.characters(number: 50) }
    note { Faker::Lorem.characters(number: 100) }
    user
  end
end
