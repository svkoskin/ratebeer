class Brewery < ActiveRecord::Base
  include AverageRating

  def year_cannot_be_in_the_future
    if year.present? && year > Time.now.year
      errors.add(:year, "can't be in the future")
    end
  end

  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  validates :name, presence: true

  validate :year_cannot_be_in_the_future
  
  validates :year, numericality: {
    greater_than_or_equal_to: 1042,
    only_integer: true
  }

  def to_s
    name
  end
end
