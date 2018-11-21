FactoryBot.define do
  factory :rating do
    value { Faker::Number.between(1, 5) }
    post_id { nil }
  end
end