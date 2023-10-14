FactoryBot.define do
  factory :menu do
    name { Faker::Food.dish }
    price { Faker::Number.decimal }
  end
end