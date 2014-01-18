class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy

  def average_rating
    if ratings.empty?
      -1
    else
      ratings.all.inject(0) { |s, r| s += r.score } / ratings.count
    end
  end

  def to_s
    "#{name} (#{brewery.name})"
  end
end
