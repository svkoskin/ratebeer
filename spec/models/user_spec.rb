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
end
