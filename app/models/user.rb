class User < ActiveRecord::Base
  include AverageRating

  validates :username, uniqueness: true, length: { minimum: 3 }

  has_many :ratings
end
