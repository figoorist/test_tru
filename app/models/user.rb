class User < ApplicationRecord
  # model association
  has_many :posts, dependent: :destroy

  # validation
  validates_with UserValidator
end
