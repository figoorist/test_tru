class Post < ApplicationRecord
  belongs_to :user
  # model association
  has_many :ratings, dependent: :destroy

  # validation
  validates_with PostValidator

  # 3. Получить топ N постов по среднему рейтингу. Просто массив объектов с заголовками и содержанием.
  def self.top(count)
    Post.all.order(average_rating: :desc).first(count)
  end

  # 4. Получить список айпи, с которых постило несколько разных авторов. Массив объектов с полями: айпи и массив логинов авторов.
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


