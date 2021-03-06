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

  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
  has_many :beers, through: :ratings

  def self.top(n)
    sorted_by_rating_in_desc_order = User.all.sort_by{ |u| - (u.ratings.count||0) }
    sorted_by_rating_in_desc_order[0...n]
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def to_s
    username
  end
end
