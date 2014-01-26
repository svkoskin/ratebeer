class Brewery < ActiveRecord::Base
  include AverageRating

  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  validates :name, presence: true
  
  validates :year, numericality: {
    greater_than_or_equal_to: 1042,
    less_than_or_equal_to: 2014,
    only_integer: true
  }

  def to_s
    name
  end
end
