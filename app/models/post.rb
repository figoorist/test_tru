class Post < ApplicationRecord
  belongs_to :user
  # model association
  has_many :ratings, dependent: :destroy

  # validation
  validates_with PostValidator
end
