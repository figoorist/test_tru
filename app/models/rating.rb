class Rating < ApplicationRecord
  belongs_to :post

  # validation
  validates_presence_of :value
end
