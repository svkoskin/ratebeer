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
      beer1 = FactoryGirl.create(:beer)
      beer2 = FactoryGirl.create(:beer)
      beer3 = FactoryGirl.create(:beer)
      rating1 = FactoryGirl.create(:rating, beer:beer1, user:user)
      rating2 = FactoryGirl.create(:rating, score:25, beer:beer2, user:user)
      rating3 = FactoryGirl.create(:rating, score:9, beer:beer3, user:user)

      expect(user.favorite_beer).to eq(beer2)
    end
  end
end
