class Rating < ApplicationRecord
  belongs_to :post

  # validation
  validates_with RatingValidator
end
