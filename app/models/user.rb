class User < ApplicationRecord
  # model association
  has_many :posts, dependent: :destroy

  # validation
  validates_presence_of :login
end
