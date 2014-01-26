class User < ActiveRecord::Base
  include AverageRating

  has_secure_password

  validates :username, uniqueness: true, length: { 
    minimum: 3, 
    maximum: 15 
  }
  validates :password, format: {
    with: /\A(.*\d+.*[A-Z]+.*)|(.*[A-Z]+.*\d+.*)\z/,
    message: "should include at least one capital letter and at least one digit"
  }
  validates :password, length: {
    minimum: 4
  }

  has_many :ratings
  has_many :beers, through: :ratings
end
