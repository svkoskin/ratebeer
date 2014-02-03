require 'spec_helper'

describe User do
  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }
    
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  it "has the username set correctly" do
    user = User.new username: "Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"
    
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end
  
  it "is not saved with a too short password" do
    user = User.create username:"Pekka", password:"aA1", password_confirmation:"aA1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with a password which has no numbers" do
    user = User.create username:"Pekka", password:"aAaa", password_confirmation:"aAaa"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  describe "favourite beer" do
    let(:user){FactoryGirl.create(:user)}

    it "has a method for determining his favorite_beer" do
      user.should respond_to :favorite_beer
    end

    it "does not have a favourite beer without ratings" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only beer if user has only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favorite_beer).to eq(best)
    end
  end
end

def create_beer_with_rating(score, user)
  beer = FactoryGirl.create(:beer)
  FactoryGirl.create(:rating, score:score, beer:beer, user:user)
  beer
end

def create_beers_with_ratings(*scores, user)
  scores.each do |score|
    create_beer_with_rating(score, user)
  end
end

