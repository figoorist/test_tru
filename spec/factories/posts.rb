FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    author_ip { Faker::Internet.ip_v4_address } 
    
    factory :post_with_ratings do
      after(:create) do |post|
        4.times do
	  create(:rating, post: post, value: 5)
        end
      end
    end
  end
end
