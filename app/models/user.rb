class User < ActiveRecord::Base
  include AverageRating

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }

  has_many :ratings
end
