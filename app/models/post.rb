class Post < ApplicationRecord
  belongs_to :user
  # model association
  has_many :ratings, dependent: :destroy

  # validation
  validates_with PostValidator

  # 3. Get first N posts ordered by average rating
  def self.top(count)
    Post.all.order(average_rating: :desc).first(count)
  end

  # 4. Get IP addresses with more then 1 users. Like [ip=>[user1, user2], [ip2=>[user1, user3]]
  def self.ips
    Post.distinct("author_ip user_id").joins(:user).pluck(:author_ip, :login).inject({}) do |mem, value|
      if mem[value[0]].nil?
        mem[value[0]] = [value[1]]
  	  else
  	    mem[value[0]].push(value[1])
  	  end
  	  mem
  	end
  end
end


