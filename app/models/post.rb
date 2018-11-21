class Post < ApplicationRecord
  belongs_to :user
  # model association
  has_many :ratings, dependent: :destroy

  # validation
  validates_presence_of :title
  validates_presence_of :body
  validates_presence_of :author_ip
end
