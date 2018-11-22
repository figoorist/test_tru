class Rating < ApplicationRecord
  belongs_to :post

  # validation
  validates_with RatingValidator

  after_create :update_post_average_rating

  def update_post_average_rating
  	self.post.update(average_rating: self.post.ratings.average("value"))
  end
end
