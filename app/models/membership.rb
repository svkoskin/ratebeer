class Membership < ActiveRecord::Base
  validates :user, uniqueness: { 
    scope: :beer_club,
    message: "is already member of the selected beer club"
  }
  
  belongs_to :user
  belongs_to :beer_club
end
