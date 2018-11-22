FactoryBot.define do
  factory :user do
    login { Faker::Internet.username(6) }

    factory :user_with_posts do
	    after(:create) do |user|
	      10.times do
	      	 create(:post, user: user)
	      end
	    end
    end

    factory :user_with_posts_with_ratings do
	    after(:create) do |user|
	      10.times do
	      	 create(:post_with_ratings, user: user)
	      end
	    end
    end
  end


end